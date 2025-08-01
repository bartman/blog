+++
title = "WeeChat spell suggestions"
date = "2008-01-05T13:28:54-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['weechat', 'irc']
keywords = ['weechat', 'irc']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I recently decided to give [WeeChat](http://weechat.flashtux.org/index.php) a try.  I found that
it had a nice new feel and less complicated windowing structure then irssi -- at least more 
intuitive to a vim user.

Here is my weechat [config](http://www.jukie.net/~bart/conf/weechat/weechat.rc).

On debian you can install it with

        apt-get install weechat-curses weechat-scripts weechat-plugins

I really liked the spell-checking plugin which uses aspell to highlight misspelled words as 
I type them.  One thing I missed was the ability to tab complete words from the 
`/usr/share/words` list.  So I wrote a [short lua script](https://github.com/bartman/snippets/blob/master/weechat/smarttab.lua) to do it...

<!--more-->

        require("string")
        require("io")

        weechat.register("smarttab", "1.0", "smarttab_cleanup", "Smart TAB handling", "ISO-8859-1")
        weechat.add_keyboard_handler("smarttab_keyboard")

        -- find the word under cursor
        function smarttab_find_word (text, pos)
                local sub_start = 0
                while true do
                        local found = string.find (text, '%W', sub_start+1)
                        if not found or found >= pos then
                                break
                        end
                        sub_start = found
                end
                sub_start = sub_start + 1

                local sub_end = string.find (text, '%W', pos)
                if not sub_end then
                        sub_end = 0
                end
                sub_end = sub_end - 1

                return sub_start, sub_end, string.sub(text,sub_start,sub_end)
        end

        local smarttab_completion_fn = nil
        local smarttab_completion_file = nil

        function smarttab_cleanup ()
                if smarttab_completion_fn then
                        smarttab_completion_file:close()
                        smarttab_completion_file = nil
                        smarttab_completion_fn = nil
                        weechat.remove_infobar()
                end
        end

        -- handle a <tab>
        function smarttab_keyboard(key, input_before, input_after)

                -- only handle <tab>
                if key ~= 'tab' then
                        smarttab_cleanup()
                        return weechat.PLUGIN_RC_OK()
                end

                -- skip if already completed
                if input_before ~= input_after then
                        smarttab_cleanup()
                        return weechat.PLUGIN_RC_OK()
                end

                local pos = tonumber(weechat.get_info ('input_pos')) + 1	-- lua index starts with 1
                local sub_start, sub_end, sub = smarttab_find_word (input_before, pos)

                --[[
                weechat.print("smarttab: key = '"..key..
                        "', input before = '"..input_before..
                        "', pos = "..pos..", completing = '"..sub..
                        "' @ "..sub_start..","..sub_end)
                ]]--

                if not smarttab_completion_fn then
                        local file = io.popen ("look '"..sub.."'")
                        smarttab_completion_fn = file:lines()
                        smarttab_completion_file = file
                end

                local new_word = smarttab_completion_fn()
                if not new_word then
                        smarttab_cleanup()
                        return weechat.PLUGIN_RC_OK()
                end

                weechat.print_infobar(0, new_word)

                return weechat.PLUGIN_RC_OK()
        end

Put this in `.weechat/lua/autoload` directory, and enable the infobar (`/set look_infobar=on`).  Pushing
*tab* on an word will show the possible substitutions.  I didn't find a way to alter the input line
so it's only being displayed in the infobar.
