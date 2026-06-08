/*
 * Copyright (C) 2008-2018 TrinityCore <https://www.trinitycore.org/>
 * Copyright (C) 2017-2018 AshamaneProject <https://github.com/AshamaneProject>
 * Copyright (C) 2026 ArgusCore <https://github.com/BlaMacfly/ArgusCore>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Banner.h"
#include "GitRevision.h"
#include "StringFormat.h"

void Trinity::Banner::Show(char const* applicationName, void(*log)(char const* text), void(*logExtraInfo)())
{
    log(Trinity::StringFormat("%s (%s)", GitRevision::GetFullVersion(), applicationName).c_str());
    log("<Ctrl-C> to stop.\n");
    log(R"BNR(    _    ____   ____ _   _ ____     ____ ___  ____  _____ )BNR");
    log(R"BNR(   / \  |  _ \ / ___| | | / ___|   / ___/ _ \|  _ \| ____|)BNR");
    log(R"BNR(  / _ \ | |_) | |  _| | | \___ \  | |  | | | | |_) |  _|  )BNR");
    log(R"BNR( / ___ \|  _ <| |_| | |_| |___) | | |__| |_| |  _ <| |___ )BNR");
    log(R"BNR(/_/   \_\_| \_\\____|\___/|____/   \____\___/|_| \_\_____|)BNR");
    log("              W o W   E m u l a t o r   P r o j e c t\n");
    log("https://github.com/BlaMacfly/ArgusCore   (based on AshamaneCore / TrinityCore)\n");

    if (logExtraInfo)
        logExtraInfo();
}
