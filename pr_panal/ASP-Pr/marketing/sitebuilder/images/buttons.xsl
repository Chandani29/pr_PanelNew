<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:output method="html" indent="no"/>
<xsl:strip-space elements="*"/>
	<!--MENU-->
	<xsl:template match="MENU" mode="top">
		<xsl:apply-templates select="MENU-ITEM"  mode="top"/>
	</xsl:template>

	<!--MENU-ITEM-->
	<xsl:template match="MENU-ITEM"  mode="top">
   		<xsl:choose>
           <!-- active menu with link-->
           	<xsl:when test="MENU-ITEM[@ID=/LAYOUT/@ID]" >
					<td valign="top" style="padding: 4px 19px 0 3px; background-image: url('images/menu_abg.gif'); background-repeat: repeat-x;"><a href="{@HREF}"><img src="images/bullet.gif" border="0" alt=""/></a></td>
					<td width="5" style="background-image: url('images/menu_abg.gif'); background-repeat: repeat-x;"></td>
					<td style="padding-right: 40px; background-image: url('images/menu_abg.gif'); background-repeat: repeat-x;"><a href="{@HREF}" class="amenu"><xsl:value-of select="@TITLE" disable-output-escaping="yes"/></a></td>
            </xsl:when>
            <!-- active menu without link-->
            <xsl:when test="MENU-ITEM[@ID=/LAYOUT/@ID] or @ID=/LAYOUT/@ID" >
					<td valign="top" style="padding: 4px 19px 0 3px; background-image: url('images/menu_abg.gif'); background-repeat: repeat-x;"><img src="images/bullet.gif" border="0" alt=""/></td>
					<td width="5" style="background-image: url('images/menu_abg.gif'); background-repeat: repeat-x;"></td>
					<td class="amenu" style="padding-right: 40px; background-image: url('images/menu_abg.gif'); background-repeat: repeat-x;"><xsl:value-of select="@TITLE" disable-output-escaping="yes"/></td>
            </xsl:when>
            <xsl:otherwise>
					<td valign="top" style="padding: 4px 19px 0 3px;"><a href="{@HREF}"><img src="images/bullet.gif" border="0" alt=""/></a></td>
					<td width="5"></td>
					<td style="padding-right: 40px;"><a href="{@HREF}" class="menu"><xsl:value-of select="@TITLE" disable-output-escaping="yes"/></a></td>
            </xsl:otherwise>
	    </xsl:choose>
		<xsl:if test="position()!=last()">
			<td width="1"><div style="width:1px; height:1px;"><spacer type="block" width="1" height="1"/></div></td>
			<td><img src="images/separator.gif" border="0" alt=""/></td>
			<td width="1"><div style="width:1px; height:1px;"><spacer type="block" width="1" height="1"/></div></td>
	</xsl:if>
	</xsl:template>	

</xsl:stylesheet>
