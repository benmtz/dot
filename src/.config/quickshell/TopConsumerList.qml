import QtQuick

Column {
  id: root

  required property var consumerList

  Repeater {
    model: root.consumerList

    Text {
      required property var modelData
      text: `${modelData.name} ${modelData.usagePercent}%`
      color: Style.text.foreground
      font.family: Style.text.family
    }
  }
}
