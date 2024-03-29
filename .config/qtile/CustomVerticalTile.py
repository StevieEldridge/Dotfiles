# Copyright (c) 2014, Florian Scherf <fscherf@gmx.net>. All rights reserved.
# Copyright (c) 2017, Dirk Hartmann.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile.layout.base import _SimpleLayoutBase


# This is a custom implementation of QTile's VerticalTile class that keeps
# the boarder when there is only one window present

class VerticalTile(_SimpleLayoutBase):
    defaults = [
        ("border_focus", "#FF0000", "Border color(s) for the focused window."),
        ("border_normal", "#FFFFFF", "Border color(s) for un-focused windows."),
        ("border_width", 1, "Border width."),
        ("margin", 0, "Border margin (int or list of ints [N E S W])."),
    ]

    ratio = 0.75
    steps = 0.05

    def __init__(self, **config):
        _SimpleLayoutBase.__init__(self, **config)
        self.add_defaults(VerticalTile.defaults)
        self.maximized = None

    def add(self, window):
        return self.clients.add(window, 1)

    def remove(self, window):
        if self.maximized is window:
            self.maximized = None
        return self.clients.remove(window)

    def clone(self, group):
        c = _SimpleLayoutBase.clone(self, group)
        c.maximized = None
        return c

    def configure(self, window, screen_rect):
        if self.clients and window in self.clients:
            n = len(self.clients)
            index = self.clients.index(window)

            # border
            border_width = self.border_width

            if window.has_focus:
                border_color = self.border_focus
            else:
                border_color = self.border_normal

            # width
            width = screen_rect.width - self.border_width * 2

            # height
            if n > 1:
                main_area_height = int(screen_rect.height * self.ratio)
                sec_area_height = screen_rect.height - main_area_height

                main_pane_height = main_area_height - border_width * 2
                sec_pane_height = sec_area_height // (n - 1) - border_width * 2
                normal_pane_height = (screen_rect.height // n) - (border_width * 2)

                if self.maximized:
                    if window is self.maximized:
                        height = main_pane_height
                    else:
                        height = sec_pane_height
                else:
                    height = normal_pane_height
            else:
                height = screen_rect.height - (border_width * 2)

            # y
            y = screen_rect.y

            if n > 1:
                if self.maximized:
                    y += (index * sec_pane_height) + (border_width * 2 * index)
                else:
                    y += (index * normal_pane_height) + (border_width * 2 * index)

                if self.maximized and window is not self.maximized:
                    if index > self.clients.index(self.maximized):
                        y = y - sec_pane_height + main_pane_height

            window.place(
                screen_rect.x, y, width, height, border_width, border_color, margin=self.margin
            )
            window.unhide()
        else:
            window.hide()

    def grow(self):
        if self.ratio + self.steps < 1:
            self.ratio += self.steps
            self.group.layout_all()

    def shrink(self):
        if self.ratio - self.steps > 0:
            self.ratio -= self.steps
            self.group.layout_all()

    cmd_previous = _SimpleLayoutBase.previous
    cmd_next = _SimpleLayoutBase.next

    cmd_up = cmd_previous
    cmd_down = cmd_next

    def cmd_shuffle_up(self):
        self.clients.shuffle_up()
        self.group.layout_all()

    def cmd_shuffle_down(self):
        self.clients.shuffle_down()
        self.group.layout_all()

    def cmd_maximize(self):
        if self.clients:
            self.maximized = self.clients.current_client
            self.group.layout_all()

    def cmd_normalize(self):
        self.maximized = None
        self.group.layout_all()

    def cmd_grow(self):
        if not self.maximized:
            return
        if self.clients.current_client is self.maximized:
            self.grow()
        else:
            self.shrink()

    def cmd_shrink(self):
        if not self.maximized:
            return
        if self.clients.current_client is self.maximized:
            self.shrink()
        else:
            self.grow()

