within ThermalAndPowerGridSystem.PowerGrid.Components;

model ConventionalGrid

  extends Icons.Grid_Icon;
  
  import SI = Modelica.Units.SI;
  
  SI.Power powerInNout " Transferred Power to/from Conventional Grid (W)";
  
  ThermalAndPowerGridSystem.PowerGrid.Interfaces.ElectricalPort electricalPort annotation(
    Placement(visible = true, transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 
equation

  electricalPort.P = -powerInNout;

annotation(
    Icon(graphics = {Text(origin = {0, -120}, extent = {{-100, 10}, {100, -10}}, textString = "%name", fontSize = 10)}),
    Documentation(info = "<html><head></head><body><!--StartFragment--><span style=\"font-family: 'DejaVu Sans Mono'; font-size: 12px;\">This component is model of conventional grid, which act as infinite source and sink for this power grid model.</span><!--EndFragment--></body></html>"));
end ConventionalGrid;
