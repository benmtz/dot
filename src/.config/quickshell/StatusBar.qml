
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts


PanelWindow {
  id: root

  anchors {
    top: true
    left: true
    right: true
  }

  RowLayout {
    StatusCpuWidget {
      id: statusCpuWidget
    }
    StatusRamWidget {
      id: statusRamWidget
      Layout.leftMargin: 16
    }
    StatusGpuWidget {
      id: statusGpuWidget
      Layout.leftMargin: 16
    }
  }

  implicitHeight: 24
  color: Style.backgroundColor
}
