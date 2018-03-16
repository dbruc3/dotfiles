#!/bin/bash
newsboat -x print-unread | cut -d' ' -f1 > ~/.tmux/.news
date +%s > ~/.tmux/.lastupdate
