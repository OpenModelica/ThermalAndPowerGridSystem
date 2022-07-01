within ThermalAndPowerGridSystem.PowerGrid.Icons;

partial class Contact_Icon "Icon for contact information"

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,70},{100,-72}},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,-72},{100,-72},{0,20},{-100,-72}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{22,0},{100,70},{100,-72},{22,0}},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,70},{100,70},{0,-20},{-100,70}},
          fillColor={241,241,241},
          fillPattern=FillPattern.Solid)}),
                            Documentation(info="<html>
<p>This icon shall be used for the contact information of the library developers.</p>
</html>"));
end Contact_Icon;
