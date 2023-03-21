from libqtile import widget

# Class responsible for initializing an array of widgets for one screen bar
class InitWidget:
    def __init__(self, scale, color, screenGroups):
        self.scale        = scale
        self.color        = color
        self.screenGroups = screenGroups


    # Initializes an array of widgets with colored backgrounds
    # @Input - A screen number for a given screen
    def coloredBackground(
        self,
        screenNum,
        barMarginX,
        sepPadding,
        groupActCol,
        groupInactCol,
        groupHighCol,
        layoutCol,
        winNameCol,
        updCol,
        cpuCol,
        ramCol,
        timeCol,
        volCol
    ):
        def scale(initValue):
            return round(initValue * self.scale)

        seperator = widget.Sep(
            linewidth = scale(0),
            padding = scale(sepPadding),
        )

        baseWidgets = [
            widget.Sep(
                linewidth = scale(0),
                padding = scale(barMarginX),
            ),
            widget.GroupBox(
                visible_groups=[char for char in self.screenGroups[screenNum]],
                borderwidth = scale(4),
                active = groupActCol,
                inactive = groupInactCol,
                highlight_color = groupHighCol,
                highlight_method = "line",
                this_current_screen_border = groupActCol,
                this_screen_border = groupActCol,
                other_current_screen_border = groupActCol,
                other_screen_border = groupActCol,
                rounded = False,
                disable_drag = True,
            ),
            widget.Sep(
                linewidth = scale(2),
                padding = scale(sepPadding),
                size_percent = 70,
            ),
            widget.CurrentLayout(
                foreground = layoutCol,
            ),
            widget.Sep(
                linewidth = scale(2),
                padding = scale(sepPadding),
                size_percent = 70,
            ),
            widget.Prompt(),
            widget.WindowName(
                foreground = winNameCol,
            ),
            widget.Chord(
                chords_colors={
                    "launch": ("#ff0000", "#ffffff"),
                },
                name_transform=lambda name: name.upper(),
            ),
            widget.Systray(
                icon_size = 20,
            ),
            seperator,
            widget.CheckUpdates(
                display_format = "upd: {updates}",
                distro = "Arch",
                no_update_string = "upd: 0",
                update_interval = 300,
                background = updCol,
                colour_no_updates = self.color["black"],
                colour_have_updates = self.color["black"],
            ),
            seperator,
            widget.CPU(
                format = "cpu: {load_percent}%",
                update_interval = 1.0,
                background = cpuCol,
                foreground = self.color["black"],
            ),
            seperator,
            widget.Memory(
                measure_mem = "G",
                update_interval = 1.0,
                format = "ram: {MemUsed: .1f} /{MemTotal: .1f}",
                background = ramCol,
                foreground = self.color["black"],
            ),
            seperator,
            widget.Clock(
                format = "%m/%d  %I:%M %p",
                background = timeCol,
                foreground = self.color["black"],
            ),
            seperator,
            widget.Volume(
                limit_max_volume=True,
                update_interval = 0.1,
                fmt = "vol: {}",
                step = 5,
                background = volCol,
                foreground = self.color["black"],
            ),
            widget.Sep(
                linewidth = scale(0),
                padding = scale(barMarginX),
            ),
        ]

        if not screenNum == 0:
            del baseWidgets[8:9]  # Removes SysTray on secondary monitors

        return baseWidgets


    # Initializes an array of widgets with colored backgrounds
    # @Input - A screen number for a given screen
    def coloredImage(
        self,
        screenNum,
        barMarginX,
        sepPadding,
        fileDir,
        groupActCol,
        groupInactCol,
        groupHighCol,
        layoutCol,
        winNameCol,
        updCol,
        cpuCol,
        ramCol,
        timeCol,
        volCol
    ):
        def scale(initValue):
            return round(initValue * self.scale)

        seperator = widget.Sep(
            linewidth = scale(0),
            padding = scale(sepPadding),
        )

        baseWidgets = [
            widget.Sep(
                linewidth = scale(0),
                padding = scale(barMarginX),
            ),
            widget.GroupBox(
                visible_groups=[char for char in self.screenGroups[screenNum]],
                borderwidth = scale(4),
                active = groupActCol,
                inactive = groupInactCol,
                highlight_color = groupHighCol,
                highlight_method = "line",
                this_current_screen_border = groupActCol,
                this_screen_border = groupActCol,
                other_current_screen_border = groupActCol,
                other_screen_border = groupActCol,
                rounded = False,
                disable_drag = True,
            ),
            widget.Sep(
                linewidth = scale(2),
                padding = scale(sepPadding),
                size_percent = 70,
            ),
            widget.CurrentLayout(
                foreground = layoutCol,
            ),
            widget.Sep(
                linewidth = scale(2),
                padding = scale(sepPadding),
                size_percent = 70,
            ),
            widget.Prompt(),
            widget.WindowName(
                foreground = winNameCol,
            ),
            widget.Chord(
                chords_colors={
                    "launch": ("#ff0000", "#ffffff"),
                },
                name_transform=lambda name: name.upper(),
            ),
            widget.Systray(
                icon_size = 20,
            ),
            seperator,
            widget.Image(
                filename = fileDir + "update.png",
                scale = "True",
            ),
            widget.CheckUpdates(
                display_format = "{updates}",
                distro = "Arch",
                no_update_string = "0",
                update_interval = 300,
                colour_have_updates = updCol,
                colour_no_updates = updCol,
                padding = 4,
            ),
            seperator,
            widget.Image(
                filename = fileDir + "cpu.png",
                scale = "True",
            ),
            widget.CPU(
                format = "{load_percent}%",
                update_interval = 1.0,
                padding = 4,
                foreground = cpuCol
            ),
            seperator,
            widget.Image(
                filename = fileDir + "ram.png",
                scale = "True",
            ),
            widget.Memory(
                measure_mem = "G",
                update_interval = 1.0,
                format = "{MemUsed: .1f} /{MemTotal: .1f}",
                padding = 0,
                foreground = ramCol,
            ),
            seperator,
            widget.Image(
                filename = fileDir + "volume.png",
                scale = "True",
            ),
            widget.Volume(
                limit_max_volume=True,
                update_interval = 0.1,
                fmt = "{}",
                step = 5,
                foreground = volCol,
            ),
            seperator,
            widget.Clock(
                format = "%m/%d  %I:%M %p",
                padding = 0,
                foreground = timeCol,
            ),
            widget.Sep(
                linewidth = scale(0),
                padding = scale(barMarginX),
            ),
            seperator,
        ]

        if not screenNum == 0:
            del baseWidgets[8:9]  # Removes SysTray on secondary monitors

        return baseWidgets
