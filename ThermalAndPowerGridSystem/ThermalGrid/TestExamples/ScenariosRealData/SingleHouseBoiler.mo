within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData;

model SingleHouseBoiler
extends Modelica.Icons.Example;
  import Modelica.Units.SI.AbsolutePressure;
  inner SystemSetup.AmbientConditions ambientConditions;

  parameter AbsolutePressure sinkPressure = 5e5;
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump pump2(massFlowRate= 7e-3) annotation(
    Placement(visible = true, transformation(origin = {149, -29}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.coldTank coldTank(InitialLevel = 16.2, TAmb(displayUnit = "K") = 313, maxHeight = 16.26, tankArea = 115.3, tankVolume = 1875)  annotation(
    Placement(visible = true, transformation(origin = {-259, 45}, extent = {{-33, -33}, {33, 33}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.hotTank hotTank(InitialLevel = 0.1, PTop(displayUnit = "Pa") = 1e5, TAmb(displayUnit = "K") = 323, maxHeight = 1.3, tankArea = 0.922, tankVolume = 1.2)  annotation(
    Placement(visible = true, transformation(origin = {61, -7}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Domestic2 domestic2(EnergyUsePerPersonPerYear = 7000000)  annotation(
    Placement(visible = true, transformation(origin = {237, 132}, extent = {{-33, -34}, {33, 34}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.PortExchange1 portExchange2 annotation(
    Placement(visible = true, transformation(origin = {-45, -87}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Boiler boiler annotation(
    Placement(visible = true, transformation(origin = {-43, -153}, extent = {{-25, -23}, {25, 23}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression fuelFlowRate(y = 0.00015)  annotation(
    Placement(visible = true, transformation(origin = {-133, -153}, extent = {{-29, -13}, {29, 13}}, rotation = 0)));
  Components.Pump pumpCold2(massFlowRate = 7e-3) annotation(
    Placement(visible = true, transformation(origin = {-179, -89}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
equation
  connect(hotTank.portB, pump2.inFlow) annotation(
    Line(points = {{99.5, -29}, {131, -29}}, color = {0, 170, 255}));
  connect(domestic2.outFlow, coldTank.portA) annotation(
    Line(points = {{273.3, 132}, {291.3, 132}, {291.3, 190}, {-295.7, 190}, {-295.7, 72}}, color = {0, 170, 255}));
  connect(portExchange2.outFlow, hotTank.portA) annotation(
    Line(points = {{-20.7, -87}, {22.5, -87}, {22.5, 22}}, color = {0, 170, 255}));
  connect(portExchange2.thermalPortIn, boiler.heatOut) annotation(
    Line(points = {{-44, -86}, {-44, -178}}, color = {255, 0, 0}));
  connect(fuelFlowRate.y, boiler.FuelFlowRate) annotation(
    Line(points = {{-101, -153}, {-70, -153}, {-70, -152}}, color = {0, 0, 127}));
  connect(pumpCold2.outFlow, portExchange2.inFlow) annotation(
    Line(points = {{-160.38, -89}, {-69.38, -89}}, color = {0, 170, 255}));
  connect(coldTank.portB, pumpCold2.inFlow) annotation(
    Line(points = {{-222.7, 23.88}, {-222.7, -89.12}, {-197.7, -89.12}}, color = {0, 170, 255}));
  connect(pump2.outFlow, domestic2.inFlow) annotation(
    Line(points = {{168, -28}, {200, -28}, {200, 132}}, color = {0, 170, 255}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-300, -200}, {300, 200}})),
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}})),
    experiment(StartTime = 0, StopTime = 86400, Tolerance = 1e-06, Interval = 172.8));
end SingleHouseBoiler;
