//-- copyright
// OpenProject is an open source project management software.
// Copyright (C) 2012-2021 the OpenProject GmbH
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License version 3.
//
// OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
// Copyright (C) 2006-2013 Jean-Philippe Lang
// Copyright (C) 2010-2013 the ChiliProject Team
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//
// See docs/COPYRIGHT.rdoc for more details.
//++

import { Injectable } from "@angular/core";
import { Store, StoreConfig } from '@datorama/akita';
import { NotificationSetting } from "core-app/features/my-account/my-notifications-page/state/notification-setting.model";

export type NotificationSettingChannel = 'mail'|'in_app';


export type NotificationSettingsState = {
  notifications:NotificationSetting[];
};

function createInitialState() {
  return { notifications: [] };
}

@Injectable()
@StoreConfig({ name: 'notification-settings' })
export class NotificationSettingsStore extends Store<NotificationSettingsState> {
  constructor() {
    super(createInitialState());
  }
}
