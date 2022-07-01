within ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions;

model SourceMT "Source boundary condition with Mass Flow Rate and Temperature specified"
extends Icons.Source;
extends SystemSetup.SystemFluid;
 SystemSetup.AmbientConditions ambientConditions;
 

   import AbsoluteTemperature = Modelica.Units.SI.Temperature;
   import AbsolutePressure = Modelica.Units.SI.AbsolutePressure;
   import  Modelica.Units.SI.MassFlowRate;
  
   parameter AbsolutePressure Pressure=1e5;
   parameter AbsoluteTemperature temperature=ambientConditions.Tambient;
   parameter MassFlowRate massFlowRate=1e3;
   
   ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort port annotation(
    Placement(visible = true, transformation(origin = {54, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {54, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 

equation
    port.massFlowRate = -massFlowRate;
    port.specificEnthalpy = FluidMedium.specificEnthalpy_pT(Pressure,temperature);
    
 
end SourceMT;
