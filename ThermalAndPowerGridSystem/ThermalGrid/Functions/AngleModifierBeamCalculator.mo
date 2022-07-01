within ThermalAndPowerGridSystem.ThermalGrid.Functions;

function AngleModifierBeamCalculator "Function which calculates Beam Solar Radiation angle modifier term based on incident angle on collector"

extends Modelica.Icons.Function;

input Real incidentAngle;
output Real angleBeamModifier;

protected
   parameter Real table[:,2]=[10,0.99; 20,0.99; 30,0.98; 40,0.96; 50,0.91; 60,0.77; 70,0.53; 80,0.18; 90,0];
   parameter Real x[:]=table[:,1];
   parameter Real y[:]=table[:,2];

algorithm

angleBeamModifier := Modelica.Math.Vectors.interpolate(x,y,incidentAngle);

end AngleModifierBeamCalculator;
