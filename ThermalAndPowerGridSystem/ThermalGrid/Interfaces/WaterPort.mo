within ThermalAndPowerGridSystem.ThermalGrid.Interfaces;

connector WaterPort "Fluid inlet/outlet connector"
extends Icons.MaterialPort; 
  import AbsolutePressure = Modelica.Units.SI.AbsolutePressure;
  import Modelica.Units.SI.MassFlowRate;
  import Modelica.Units.SI.SpecificEnthalpy;
  
  AbsolutePressure pressure "Potential variable";
  flow MassFlowRate massFlowRate(start=0.0) "Positive when flowing into the system, negative otherwise";
  stream SpecificEnthalpy specificEnthalpy "Stream variable";
 
end WaterPort;
