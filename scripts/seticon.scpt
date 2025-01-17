#!/usr/bin/env osascript
(*
  Set a custom icon for a file or application.
  Usage: seticon.scpt <icon_path> <target_path>
*)

use framework "AppKit"

property this : a reference to current application
property NSWorkspace : a reference to NSWorkspace of this
property NSImage : a reference to NSImage of this

on run argv
  # Validate arguments
  if (count of argv) is not equal to 2 then
    error "Usage: seticon.scpt <icon_path> <target_path>" number 1
  end if

  set iconPath to item 1 of argv
  set targetPath to item 2 of argv

  # Load the icon image
  set iconImage to (NSImage's alloc())'s initWithContentsOfFile:iconPath
  if iconImage is missing value then
    error "Icon file not found: " & iconPath number 2
  end if

  # Apply the icon to the target file
  set success to (NSWorkspace's sharedWorkspace()'s setIcon:iconImage forFile:targetPath options:0) as boolean

  if not success then
    error "Failed to set icon for: " & targetPath number 3
  end if
end run
