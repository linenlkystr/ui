import QtQuick 2.4

UIPlotSeriesForm {
  property double period : 1.0
  property double amplitude : 1.0
  property double x_s : 0
  property bool timerOn : false

  Timer {
    id: plotTimer
    interval: 100; running: timerOn; repeat: true
    onTriggered: genPoint()
  }

  function genPoint() {
    x_s = x_s + plotTimer.interval / 1000;
    var b = 2 * Math.PI / period;
    var y = amplitude * Math.sin(b * x_s);
    lSeries.append(x_s, y);
    return y;
  }

  function clear(){
    x_s = 0
    timerOn = false
    var numPoints = lSeries.count
    lSeries.removePoints(0,numPoints)
  }
}
