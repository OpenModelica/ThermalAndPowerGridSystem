within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.Scenarios;

model SolarHeatGeneration
  import Modelica.Units.SI.AbsolutePressure;
  inner SystemSetup.AmbientConditions ambientConditions;
  extends Modelica.Icons.Example;
  parameter Real[12] cumDays = {31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365};
  Real hour, days;
  //Real mfr(start = 14);
  parameter AbsolutePressure sinkPressure = 3e5;
  ThermalAndPowerGridSystem.ThermalGrid.Components.PortExchange1 portExchange1 annotation(
    Placement(visible = true, transformation(origin = {8, 34}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SourceMT sourceMT(massFlowRate = 71, temperature(displayUnit = "K")) annotation(
    Placement(visible = true, transformation(origin = {-286, 166}, extent = {{-82, -82}, {82, 82}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SinkP sinkP(P = 600000) annotation(
    Placement(visible = true, transformation(origin = {263, 159}, extent = {{-73, -73}, {73, 73}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.LinearValve linearValve annotation(
    Placement(visible = true, transformation(origin = {-206, 132}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Domestic2 domestic2(EnergyUsePerPersonPerYear = 7000000000) annotation(
    Placement(visible = true, transformation(origin = {175, 36}, extent = {{-47, -44}, {47, 44}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.coldTank coldTank(InitialLevel = 2500000, PTop(displayUnit = "Pa") = 2e5, tankVolume = 500000000) annotation(
    Placement(visible = true, transformation(origin = {-146, 38}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump pump(massFlowRate = 7)  annotation(
    Placement(visible = true, transformation(origin = {-74, 24}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BaseComponents.SolarCSP solarCSP annotation(
    Placement(visible = true, transformation(origin = {11, -94}, extent = {{-33, -30}, {33, 30}}, rotation = 0)));
equation
//  (mfr - 7) =((700-7)/(2073-293))*(pre(portExchange1.temperature) -293);
  hour = mod(div(time, 3600), 24);
  days = div(time, 3600 * 24);
//  if days < cumDays[1] - 1e-8 then
//    mfr = 14;
//  elseif days < cumDays[2] - 1e-8 then
//    mfr = 24;
//  elseif days < cumDays[3] - 1e-8 then
//    mfr = 34;
//  elseif days < cumDays[4] - 1e-8 then
//    mfr = 44;
//  elseif days < cumDays[5] - 1e-8 then
//    mfr = 54;
//  elseif days < cumDays[6] - 1e-8 then
//    mfr = 64;
//  elseif days < cumDays[7] - 1e-8 then
//    mfr = 74;
//  elseif days < cumDays[8] - 1e-8 then
//    mfr = 84;
//  elseif days < cumDays[9] - 1e-8 then
//    mfr = 94;
//  elseif days < cumDays[10] - 1e-8 then
//    mfr = 104;
//  elseif days < cumDays[11] - 1e-8 then
//    mfr =114;
//  elseif days < cumDays[12] - 1e-8 then
//    mfr = 124;
//  else
//    mfr = 14;
//  end if;
  connect(sourceMT.port, linearValve.portA) annotation(
    Line(points = {{-242, 164}, {-223, 164}, {-223, 127}}, color = {0, 170, 255}));
  connect(portExchange1.outFlow, domestic2.inFlow) annotation(
    Line(points = {{41, 35}, {67.5, 35}, {67.5, 36}, {123, 36}}, color = {0, 170, 255}));
  connect(domestic2.outFlow, sinkP.port) annotation(
    Line(points = {{227, 36}, {227, 94}, {226, 94}, {226, 158}}, color = {0, 170, 255}));
  connect(linearValve.portB, coldTank.portA) annotation(
    Line(points = {{-188, 127}, {-188, 98.5}, {-174, 98.5}, {-174, 60}}, color = {0, 170, 255}));
  connect(coldTank.portB, pump.inFlow) annotation(
    Line(points = {{-118, 22}, {-94, 22}, {-94, 24}}, color = {0, 170, 255}));
  connect(pump.outFlow, portExchange1.inFlow) annotation(
    Line(points = {{-54, 24}, {-24, 24}, {-24, 33}}, color = {0, 170, 255}));
  connect(portExchange1.thermalPortIn, solarCSP.heatOutput) annotation(
    Line(points = {{8, 34}, {12, 34}, {12, -126}}, color = {255, 0, 0}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-300, -200}, {300, 200}})),
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}})),
    experiment(StartTime = 0, StopTime = 2678400, Tolerance = 1e-06, Interval = 5378.31));
end SolarHeatGeneration;
