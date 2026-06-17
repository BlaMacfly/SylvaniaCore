/*
 * This file is part of the DestinyCore Project. See AUTHORS file for Copyright information
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

void Destiny::Banner::Show(char const* applicationName, void(*log)(char const* text), void(*logExtraInfo)())
{
    log(Trinity::StringFormat("%s (%s)", GitRevision::GetFullVersion(), applicationName).c_str());
    log(R"(<Ctrl-C> to stop.)" "\n");
    log(R"( ____                    __)");
    log(R"(/\  _`\                 /\ \__  __)");
    log(R"(\ \ \/\ \     __    ____\ \ ,_\/\_\    ___   __  __)");
    log(R"( \ \ \ \ \  /'__`\ /',__\\ \ \/\/\ \ /' _ `\/\ \/\ \)");
    log(R"(  \ \ \_\ \/\  __//\__, `\\ \ \_\ \ \/\ \/\ \ \ \_\ \)");
    log(R"(   \ \____/\ \____\/\____/ \ \__\\ \_\ \_\ \_\/`____ \)");
    log(R"(    \/___/  \/____/\/___/   \/__/ \/_/\/_/\/_/`/___/> \)");
    log(R"(                                        C O R E  /\___/)");
    log(R"(https://DestinyCore.org                          \/__/)" "\n");

    if (logExtraInfo)
        logExtraInfo();
}
