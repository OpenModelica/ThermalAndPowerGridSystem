within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ComponentTest.StratifiedTankTest;

model TEStrialChargingDischarging
  extends Modelica.Icons.Example;
  Integer mode(start = 1, fixed = true);
  Real hour;
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SinkT sinkT annotation(
    Placement(visible = true, transformation(origin = {60, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SourceT sourceThot(hotWaterTemperature = 368.15) annotation(
    Placement(visible = true, transformation(origin = {-56, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Storage.cylindricalTESTopNode cylindricalTESTopNode annotation(
    Placement(visible = true, transformation(origin = {0, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Storage.cylindricalTESBottomNode cylindricalTESBottomNode annotation(
    Placement(visible = true, transformation(origin = {0, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SourceT sourceTcold(hotWaterTemperature = 333.15) annotation(
    Placement(visible = true, transformation(origin = {56, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SinkT sinkT1 annotation(
    Placement(visible = true, transformation(origin = {-58, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Storage.cylindricalTESnode Node2 annotation(
    Placement(visible = true, transformation(origin = {0, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Storage.cylindricalTESnode Node3 annotation(
    Placement(visible = true, transformation(origin = {0, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Storage.cylindricalTESnode Node4 annotation(
    Placement(visible = true, transformation(origin = {0, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Storage.cylindricalTESnode Node5 annotation(
    Placement(visible = true, transformation(origin = {0, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Storage.cylindricalTESnode Node6 annotation(
    Placement(visible = true, transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Storage.cylindricalTESnode Node7 annotation(
    Placement(visible = true, transformation(origin = {0, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Storage.cylindricalTESnode Node9 annotation(
    Placement(visible = true, transformation(origin = {0, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Storage.cylindricalTESnode Node8 annotation(
    Placement(visible = true, transformation(origin = {0, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  hour = mod(div(time, 3600), 24);
when hour>2-1e-8 then 
    mode = 2;
   elsewhen hour > 1 - 1e-8 then
    mode = 3;
  end when;
  cylindricalTESBottomNode.mode = mode;
  Node2.mode = mode;
  Node3.mode = mode;
  Node4.mode = mode;
  Node5.mode = mode;
  Node6.mode = mode;
  Node7.mode = mode;
  Node8.mode = mode;
  Node9.mode = mode;
  cylindricalTESTopNode.mode = mode;
  connect(sourceThot.tempOut, cylindricalTESTopNode.hotIn) annotation(
    Line(points = {{-56, 88}, {-8, 88}, {-8, 78}}));
  connect(cylindricalTESTopNode.hotOut, sinkT.tempIn) annotation(
    Line(points = {{8, 78}, {8, 88}, {60, 88}}));
  connect(sourceTcold.tempOut, cylindricalTESBottomNode.coldIn) annotation(
    Line(points = {{56, -88}, {6, -88}, {6, -79}}));
  connect(cylindricalTESBottomNode.coldOut, sinkT1.tempIn) annotation(
    Line(points = {{-8, -79}, {-8, -88}, {-58, -88}}));
  connect(cylindricalTESTopNode.coldOut, Node2.hotIn) annotation(
    Line(points = {{-8, 68}, {-8, 62}}));
  connect(Node2.coldOut, Node3.hotIn) annotation(
    Line(points = {{-8, 52}, {-8, 44}}));
  connect(Node3.coldOut, Node4.hotIn) annotation(
    Line(points = {{-8, 34}, {-8, 28}}));
  connect(Node4.coldOut, Node5.hotIn) annotation(
    Line(points = {{-8, 18}, {-8, 12}}));
  connect(Node5.coldOut, Node6.hotIn) annotation(
    Line(points = {{-8, 2}, {-8, -4}}));
  connect(Node6.coldOut, Node7.hotIn) annotation(
    Line(points = {{-8, -14}, {-8, -20}}));
  connect(Node9.coldOut, cylindricalTESBottomNode.hotIn) annotation(
    Line(points = {{-8, -62}, {-8, -68}}));
  connect(cylindricalTESBottomNode.hotOut, Node9.coldIn) annotation(
    Line(points = {{8, -68}, {8, -62}}));
  connect(Node9.hotOut, Node8.coldIn) annotation(
    Line(points = {{8, -52}, {8, -47}}));
  connect(Node8.coldOut, Node9.hotIn) annotation(
    Line(points = {{-8, -47}, {-8, -52}}));
  connect(Node7.coldOut, Node8.hotIn) annotation(
    Line(points = {{-8, -30}, {-8, -36}}));
  connect(Node7.coldIn, Node8.hotOut) annotation(
    Line(points = {{8, -30}, {8, -36}}));
  connect(Node7.hotOut, Node6.coldIn) annotation(
    Line(points = {{8, -20}, {8, -14}}));
  connect(Node6.hotOut, Node5.coldIn) annotation(
    Line(points = {{8, -4}, {8, 2}}));
  connect(Node5.hotOut, Node4.coldIn) annotation(
    Line(points = {{8, 12}, {8, 18}}));
  connect(Node4.hotOut, Node3.coldIn) annotation(
    Line(points = {{8, 28}, {8, 34}}));
  connect(Node3.hotOut, Node2.coldIn) annotation(
    Line(points = {{8, 44}, {8, 52}}));
  connect(Node2.hotOut, cylindricalTESTopNode.coldIn) annotation(
    Line(points = {{8, 62}, {8, 68}}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 8000, Tolerance = 1e-6, Interval = 16));
end TEStrialChargingDischarging;
