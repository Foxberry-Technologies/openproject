#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2023 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

module OpTurbo
  module OpPrimer
    class AsyncDialogComponent < ApplicationComponent
      include ApplicationHelper
      include ::OpPrimer::ComponentHelpers

      def initialize(id:, src:, title:, button_icon: nil, button_text: nil, button_attributes: {}, size: :auto)
        super

        @id = id
        @src = src
        @title = title
        @size = size
        @button_icon = button_icon
        @button_text = button_text
        @button_attributes = button_attributes
      end

      def call
        render(Primer::Box.new(data: stimulus_attributes)) do
          render(Primer::Alpha::Dialog.new(
                   id: @id,
                   title: @title,
                   size: @size
                 )) do |dialog|
            button_partial(dialog)
            frame_partial
          end
        end
      end

      private

      def stimulus_attributes
        {
          controller: 'op-turbo-op-primer-async-dialog',
          'application-target': 'dynamic'
        }
      end

      def button_partial(dialog)
        dialog.with_show_button(**merged_button_attributes) do |button|
          button.with_leading_visual_icon(icon: @button_icon) if @button_icon
          @button_text
        end
      end

      def merged_button_attributes
        stimuls_action_ref = 'click->op-turbo-op-primer-async-dialog#reinitFrame'

        @button_attributes[:data] = {} if @button_attributes[:data].nil?
        @button_attributes[:data][:action] = stimuls_action_ref

        @button_attributes
      end

      def frame_partial
        content_tag("turbo-frame",
                    id: "#{@id}-frame",
                    loading: :lazy,
                    src: @src,
                    data: { 'op-turbo-op-primer-async-dialog-target': "frameElement" }) do
          loading_state_partial
        end
      end

      def loading_state_partial
        flex_layout(justify_content: :center) do |flex|
          flex.with_column(my: 5) do
            render(Primer::Beta::Spinner.new)
          end
        end
      end
    end
  end
end
