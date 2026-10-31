import Quickshell
import Quickshell.Io // for Process
import QtQuick

ShellRoot {
  id: shell

  readonly property int widgetSpacing: 10

  StatusBar {
    id: statusBar
  }

  CpuWidget {
    id: cpuWidget
  }

  DatetimeWidget {
    id: datetimeWidget
  }

  RamWidget {
    id: ramWidget
    margins.top: cpuWidget.margins.top + cpuWidget.implicitHeight + shell.widgetSpacing
  }

  NvidiaGpuWidget {
    id: nvidiaGpuWidget
    margins.top: ramWidget.margins.top + ramWidget.implicitHeight + shell.widgetSpacing
  }

  ContainerWidget {
    margins.top: nvidiaGpuWidget.margins.top + nvidiaGpuWidget.implicitHeight + shell.widgetSpacing
  }

}
