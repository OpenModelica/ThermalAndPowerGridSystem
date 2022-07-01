within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ComponentTest.StratifiedTankTest;

model BoreholeTEStrial
extends Modelica.Icons.Example;
  inner SystemSetup.AmbientConditions ambientConditions;
  Boolean coldInValveSwitch, coldOutValveSwitch, hotInValveSwitch, hotOutValveSwitch;
 
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SourceMT hotSource(temperature(displayUnit = "K") = 363) annotation(
    Placement(visible = true, transformation(origin = {-79, 77}, extent = {{-39, -39}, {39, 39}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SourceMT coldSource(temperature(displayUnit = "K") = 333) annotation(
    Placement(visible = true, transformation(origin = {83, -67}, extent = {{39, -39}, {-39, 39}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SinkP hotSink annotation(
    Placement(visible = true, transformation(origin = {79, 75}, extent = {{-41, -41}, {41, 41}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SinkP coldSink annotation(
    Placement(visible = true, transformation(origin = {-79, -67}, extent = {{39, -39}, {-39, 39}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Storage.BoreholeTESports2 boreholeTESports2 annotation(
    Placement(visible = true, transformation(origin = {5, -2}, extent = {{-27, -30}, {27, 30}}, rotation = 0)));
  Components.LinearValve coldOutValve(valveSwitch = coldOutValveSwitch) annotation(
    Placement(visible = true, transformation(origin = {-40, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.LinearValve hotOutValve(valveSwitch = hotOutValveSwitch) annotation(
    Placement(visible = true, transformation(origin = {42, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.LinearValve hotInValve(valveSwitch = hotInValveSwitch) annotation(
    Placement(visible = true, transformation(origin = {-40, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.LinearValve coldInValve(valveSwitch = coldInValveSwitch) annotation(
    Placement(visible = true, transformation(origin = {46, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
algorithm
 when initial() then
//  if boreholeTESports2.mode == 1 then
    hotInValveSwitch := true;
    coldOutValveSwitch := true;
    hotOutValveSwitch := false;
    coldOutValveSwitch := false;
end when;
 when boreholeTESports2.mode==2 then    
//  elseif boreholeTESports2.mode == 2 then
    hotInValveSwitch := false;
    coldOutValveSwitch := false;
    hotOutValveSwitch := true;
    coldOutValveSwitch := true;
 end when;   
 when boreholeTESports2.mode==3 then
    hotInValveSwitch := false;
    coldOutValveSwitch := false;
    hotOutValveSwitch := false;
    coldOutValveSwitch := false;
//  end if;
end when;
 equation
  connect(boreholeTESports2.coldOut, coldOutValve.portB) annotation(
    Line(points = {{-24, -26}, {-30, -26}, {-30, -52}}, color = {0, 170, 255}));
  connect(coldOutValve.portA, coldSink.port) annotation(
    Line(points = {{-50, -52}, {-60, -52}, {-60, -68}}, color = {0, 170, 255}));
  connect(boreholeTESports2.hotOut, hotOutValve.portA) annotation(
    Line(points = {{34, 22}, {32, 22}, {32, 42}}, color = {0, 170, 255}));
  connect(hotOutValve.portB, hotSink.port) annotation(
    Line(points = {{52, 42}, {58, 42}, {58, 74}}, color = {0, 170, 255}));
  connect(hotSource.port, hotInValve.portA) annotation(
    Line(points = {{-58, 76}, {-50, 76}, {-50, 40}}, color = {0, 170, 255}));
  connect(hotInValve.portB, boreholeTESports2.hotIn) annotation(
    Line(points = {{-30, 40}, {-24, 40}, {-24, 22}}, color = {0, 170, 255}));
  connect(coldSource.port, coldInValve.portB) annotation(
    Line(points = {{62, -68}, {56, -68}, {56, -46}}, color = {0, 170, 255}));
  connect(coldInValve.portA, boreholeTESports2.coldIn) annotation(
    Line(points = {{36, -46}, {36, -37}, {34, -37}, {34, -28}}, color = {0, 170, 255}));
  annotation(
    experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-06, Interval = 63072));
end BoreholeTEStrial;
