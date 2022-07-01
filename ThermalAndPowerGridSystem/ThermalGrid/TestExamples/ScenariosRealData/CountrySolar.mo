within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData;

model CountrySolar
  import Modelica.Units.SI.AbsolutePressure;
  inner SystemSetup.AmbientConditions ambientConditions;
  extends Modelica.Icons.Example;
  parameter Real[12] cumDays = {31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365};
  Real hour, days;
  //Real mfr(start = 14);
  parameter AbsolutePressure sinkPressure = 3e5;
  ThermalAndPowerGridSystem.ThermalGrid.Components.PortExchange1 portExchange1 annotation(
    Placement(visible = true, transformation(origin = {22, 36}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.coldTank coldTank(InitialLevel = 10e5, PTop(displayUnit = "Pa") = 2e5, tankArea = 10e5, tankVolume = 10e10) annotation(
    Placement(visible = true, transformation(origin = {-146, 38}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump pump(massFlowRate = 220000) annotation(
    Placement(visible = true, transformation(origin = {-74, 24}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BaseComponents.SolarCSP2 solarCSP2(NumberOfCollectors = 19000000) annotation(
    Placement(visible = true, transformation(origin = {22, -101}, extent = {{-24, -25}, {24, 25}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Utilities.SolarIrradianceData solarIrradianceData(solarIrradianceData = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/Resources/DirectSolarIrradiance.txt")) annotation(
    Placement(visible = true, transformation(origin = {-59, -105}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents.SpaceHeating spaceHeating annotation(
    Placement(visible = true, transformation(origin = {171, 38}, extent = {{-25, -24}, {25, 24}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression heatload(y = 46000) annotation(
    Placement(visible = true, transformation(origin = {102, -37}, extent = {{-24, -13}, {24, 13}}, rotation = 0)));
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
  connect(coldTank.portB, pump.inFlow) annotation(
    Line(points = {{-118, 22}, {-94, 22}, {-94, 24}}, color = {0, 170, 255}));
  connect(pump.outFlow, portExchange1.inFlow) annotation(
    Line(points = {{-54, 24}, {-10, 24}, {-10, 35}}, color = {0, 170, 255}));
  connect(solarCSP2.heatOutput, portExchange1.thermalPortIn) annotation(
    Line(points = {{22, -128.5}, {22, -43.25}, {23, -43.25}, {23, 36}}, color = {255, 0, 0}));
  connect(solarIrradianceData.cspIrradiance, solarCSP2.directIrradiation) annotation(
    Line(points = {{-36, -105}, {-37, -105}, {-37, -104}, {-6, -104}}, color = {0, 0, 127}));
  connect(portExchange1.outFlow, spaceHeating.inFlow) annotation(
    Line(points = {{54, 36}, {99.75, 36}, {99.75, 38}, {143.5, 38}}, color = {0, 170, 255}));
  connect(spaceHeating.heatDemand, heatload.y) annotation(
    Line(points = {{141, 22}, {128, 22}, {128, -37}}, color = {0, 0, 127}));
  connect(spaceHeating.outFlow, coldTank.portA) annotation(
    Line(points = {{198, 38}, {238, 38}, {238, 144}, {-174, 144}, {-174, 60}}, color = {0, 170, 255}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-300, -200}, {300, 200}})),
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}})),
    experiment(StartTime = 0, StopTime = 31536000, Tolerance = 1e-06, Interval = 3600));
end CountrySolar;
