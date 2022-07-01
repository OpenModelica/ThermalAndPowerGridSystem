within ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions;

model SourcePT "Source boundary condition with Pressure and Temperature conditions specified"
extends SystemSetup.SystemFluid; 
extends Icons.Source;
   
   import AbsoluteTemperature = Modelica.Units.SI.Temperature;
   import AbsolutePressure = Modelica.Units.SI.AbsolutePressure;
   import SpecificEnthalpy = Modelica.Units.SI.SpecificEnthalpy; 
   
   parameter AbsolutePressure Pressure(start=1e5);
   parameter AbsoluteTemperature Temperature(start=300);
   
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort port annotation(
    Placement(visible = true, transformation(origin = {56, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {54, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
    port.pressure = Pressure;
    port.specificEnthalpy = FluidMedium.specificEnthalpy_pT(Pressure,Temperature);
end SourcePT;
