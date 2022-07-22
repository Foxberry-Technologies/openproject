#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2022 the OpenProject GmbH
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

# Please see https://w3c.github.io/webappsec-secure-contexts/
# for a definition of "secure contexts".
# Basically, a host has to have either a HTTPS scheme or be
# localhost to provide a secure context.
class SecureContextUriValidator < ActiveModel::EachValidator
  def validate_each(contract, attribute, value)
    begin
      uri = URI.parse(value)
    rescue StandardError
      uri = nil
    end

    if uri.nil? || uri.host.nil?
      contract.errors.add(attribute, :could_not_parse_host_uri)
      return
    end

    if check_invalid_uri(uri)
      contract.errors.add(attribute, :uri_not_secure_context)
    end
  end

  private

  def check_invalid_uri(uri)
    return false if uri.scheme == 'https' # https is always safe
    return false if uri.host == 'localhost' # Simple localhost
    return false if uri.host =~ /\.localhost\.?$/ # i.e. 'foo.localhost' or 'foo.localhost.'

    # Check for loopback interface. The constructor can throw an exception for non IP addresses.
    # Those are invalid. And if the host is an IP address then we can check if it is loopback.
    begin
      return false if IPAddr.new(uri.host).loopback?
    rescue StandardError
      return true
    end
    true
  end
end
