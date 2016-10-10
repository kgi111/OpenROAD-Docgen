<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" encoding="ISO-8859-1" indent="yes"/>

<xsl:template match="/">
	<application>
		<xsl:attribute name="name">
  	    		<xsl:value-of select="application/@name"/>
   	   	</xsl:attribute>
		<xsl:for-each select = "/application" >
			<xsl:call-template name="attr"/>
		</xsl:for-each>
		<xsl:call-template name="userClass"/>
		<xsl:call-template name="GL4Procedure"/>
		<xsl:call-template name="frame"/>
		<xsl:call-template name="ghostFrame"/>
		<xsl:call-template name="includeScript"/>
		<xsl:call-template name="GlobalConstant"/>
		<xsl:call-template name="GlobalVariable"/>
		<xsl:call-template name="GL3Procedure"/>		
		<xsl:call-template name="FieldTemplate"/>
		<xsl:call-template name="externClass"/>
	</application>
</xsl:template> 

<xsl:template name="userClass">
	<userClasses>
		<xsl:for-each select = "//UserClass" >
		<xsl:if test="not(attr[3]/@lowerValue='generated scp - not viewable')">
		<userClass>		
			<xsl:call-template name="attr"/>
			<attributeObjects>
				<xsl:for-each select = "attributeObjects/attributeObject" >			
				<attributeObject>
					<xsl:if test="attrs/attr/@internal='true'">
						<xsl:attribute name="internal">
							<xsl:value-of select="attrs/attr/@internal"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:call-template name="attr"/>
					<attrs>
					<xsl:for-each select = "attrs/attr" >
					<attr>
						<xsl:attribute name="line">
							<xsl:value-of select="@line"/>
						</xsl:attribute>
						<xsl:value-of select="."/>
					</attr>
					</xsl:for-each>
					</attrs>
				</attributeObject>
				</xsl:for-each>
			</attributeObjects>
			<methodScripts>
			<xsl:for-each select = "methodScripts/methodScript" >			
				<methodScript>
					<xsl:call-template name="internal">
						<xsl:with-param name="name">
							<xsl:value-of select="attr[1]/@lowerValue"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="attr"/>
					<attrs>
					<xsl:for-each select = "attrs/attr" >
						<attr>
						<xsl:attribute name="line">
							<xsl:value-of select="@line"/>
						</xsl:attribute>
						<xsl:value-of select="."/>
						</attr>
					</xsl:for-each>
					</attrs>
				</methodScript>
			</xsl:for-each>
			</methodScripts>
			<methods>
				<xsl:for-each select = "methods/method" >			
				<method>
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
					<xsl:attribute name="lowerName">
						<xsl:value-of select="@lowerName"/>
					</xsl:attribute>
					<xsl:if test="@internal='true'">
						<xsl:attribute name="internal">
							<xsl:value-of select="@internal"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:for-each select = "description" >
						<description>
							<xsl:attribute name="line">
								<xsl:value-of select="@line"/>
							</xsl:attribute>
							<xsl:value-of select="."/>
						</description>
					</xsl:for-each>
					<inputParams>
						<xsl:for-each select = "inputParams/inputParam" >
						<inputParam>
							<xsl:attribute name="name">
								<xsl:value-of select="@name"/>
							</xsl:attribute>
							<xsl:for-each select = "description" >
							<description>
								<xsl:attribute name="line">
									<xsl:value-of select="@line"/>
								</xsl:attribute>
								<xsl:value-of select="."/>								
							</description>							
							</xsl:for-each>
							<paramType>
							<xsl:call-template name="paramType">
								<xsl:with-param name="name">
									<xsl:value-of select="@lowerValue"/>
								</xsl:with-param>
							</xsl:call-template>							
							</paramType>
						</inputParam>
						</xsl:for-each>
					</inputParams>
					<return>
						<xsl:for-each select = "return/description" >
						<description>
							<xsl:attribute name="line">
								<xsl:value-of select="@line"/>
							</xsl:attribute>
							<xsl:value-of select="."/>
						</description>
						</xsl:for-each>
						<returnType>
							<xsl:call-template name="returnType">
								<xsl:with-param name="name">
									<xsl:value-of select="@lowerName"/>
								</xsl:with-param>
							</xsl:call-template>							
						</returnType>
					</return>
					<xsl:call-template name="throws"/>
					<xsl:call-template name="seeAlso"/>
				</method>
				</xsl:for-each>
			</methods>			
		</userClass>
		</xsl:if>
		</xsl:for-each>		
	</userClasses>
</xsl:template> 

<xsl:template name="GL4Procedure">
	<GL4Procedures>
		<xsl:for-each select = "//GL4Procedure" >
		<xsl:if test="not(attr[3]/@lowerValue='generated scp - not viewable')">
		<GL4Procedure>		
			<xsl:call-template name="attr"/>			
			<methods>
				<xsl:for-each select = "methods/method" >			
				<method>
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
					<xsl:for-each select = "description" >
					<description>
						<xsl:attribute name="line">
							<xsl:value-of select="@line"/>
						</xsl:attribute>
						<xsl:value-of select="."/>
					</description>
					</xsl:for-each>
					<inputParams>
						<xsl:for-each select = "inputParams/inputParam" >
						<inputParam>
							<xsl:attribute name="name">
								<xsl:value-of select="@name"/>
							</xsl:attribute>
							<xsl:for-each select = "description" >
							<description>
								<xsl:attribute name="line">
									<xsl:value-of select="@line"/>
								</xsl:attribute>
								<xsl:value-of select="."/>								
							</description>							
							</xsl:for-each>
							<paramType>
							<xsl:call-template name="paramType">
								<xsl:with-param name="name">
									<xsl:value-of select="@lowerValue"/>
								</xsl:with-param>
							</xsl:call-template>							
							</paramType>
						</inputParam>
						</xsl:for-each>
					</inputParams>
					<return>
						<xsl:for-each select = "return/description" >
						<description>
							<xsl:attribute name="line">
								<xsl:value-of select="@line"/>
							</xsl:attribute>
							<xsl:value-of select="."/>
						</description>
						</xsl:for-each>
						<returnType>
							<xsl:call-template name="returnTypeGL4Procedure"/>
						</returnType>
					</return>
					<xsl:call-template name="throws"/>
					<xsl:call-template name="seeAlso"/>
				</method>
				</xsl:for-each>
			</methods>
		</GL4Procedure>
		</xsl:if>
		</xsl:for-each>
	</GL4Procedures>
</xsl:template> 

<xsl:template name="frame">
	<frames>
		<xsl:for-each select = "//Frame" >
		<xsl:if test="not(attr[3]/@lowerValue='generated scp - not viewable')">
		<frame>		
			<xsl:call-template name="attr"/>			
			<methods>
				<xsl:for-each select = "methods/method" >			
				<method>											
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>	
					<xsl:attribute name="internal">
						<xsl:value-of select="@internal"/>
					</xsl:attribute>	
					<xsl:for-each select = "description" >
					<description>
						<xsl:attribute name="line">
							<xsl:value-of select="@line"/>
						</xsl:attribute>
						<xsl:value-of select="."/>
					</description>
					</xsl:for-each>
					<inputParams>
						<xsl:for-each select = "inputParams/inputParam" >
						<inputParam>
							<xsl:attribute name="name">
								<xsl:value-of select="@name"/>
							</xsl:attribute>
							<xsl:for-each select = "description" >
							<description>
								<xsl:attribute name="line">
									<xsl:value-of select="@line"/>
								</xsl:attribute>
								<xsl:value-of select="."/>								
							</description>							
							</xsl:for-each>
							<paramType>
							<xsl:call-template name="paramType">
								<xsl:with-param name="name">
									<xsl:value-of select="@lowerValue"/>
								</xsl:with-param>
							</xsl:call-template>							
							</paramType>
						</inputParam>
						</xsl:for-each>
					</inputParams>
					<return>
						<xsl:for-each select = "return/description" >
						<description>
							<xsl:attribute name="line">
								<xsl:value-of select="@line"/>
							</xsl:attribute>
							<xsl:value-of select="."/>
						</description>
						</xsl:for-each>
						<returnType>
							<xsl:call-template name="returnTypeGL4Procedure"/>
						</returnType>
					</return>
					<xsl:call-template name="throws"/>
					<xsl:call-template name="seeAlso"/>
				</method>
				</xsl:for-each>
			</methods>
		</frame>
		</xsl:if>
		</xsl:for-each>
	</frames>
</xsl:template> 

<xsl:template name="ghostFrame">
	<ghostFrames>
		<xsl:for-each select = "//GhostFrame" >
		<xsl:if test="not(attr[3]/@lowerValue='generated scp - not viewable')">
		<ghostFrame>		
			<xsl:call-template name="attr"/>			
			<methods>
				<xsl:for-each select = "methods/method" >			
				<method>
					<xsl:call-template name="returnName"/>
					<xsl:for-each select = "description" >
					<description>
						<xsl:attribute name="line">
							<xsl:value-of select="@line"/>
						</xsl:attribute>
						<xsl:value-of select="."/>
					</description>
					</xsl:for-each>
					<inputParams>
						<xsl:for-each select = "inputParams/inputParam" >
						<inputParam>
							<xsl:attribute name="name">
								<xsl:value-of select="@name"/>
							</xsl:attribute>
							<xsl:for-each select = "description" >
							<description>
								<xsl:attribute name="line">
									<xsl:value-of select="@line"/>
								</xsl:attribute>
								<xsl:value-of select="."/>								
							</description>							
							</xsl:for-each>
							<paramType>
							<xsl:call-template name="paramType">
								<xsl:with-param name="name">
									<xsl:value-of select="@lowerValue"/>
								</xsl:with-param>
							</xsl:call-template>							
							</paramType>
						</inputParam>
						</xsl:for-each>
					</inputParams>
					<return>
						<xsl:for-each select = "return/description" >
						<description>
							<xsl:attribute name="line">
								<xsl:value-of select="@line"/>
							</xsl:attribute>
							<xsl:value-of select="."/>
						</description>
						</xsl:for-each>
						<returnType>
							<xsl:call-template name="returnTypeGL4Procedure"/>
						</returnType>
					</return>
					<xsl:call-template name="throws"/>
					<xsl:call-template name="seeAlso"/>
				</method>
				</xsl:for-each>
			</methods>
		</ghostFrame>
		</xsl:if>
		</xsl:for-each>		
	</ghostFrames>
</xsl:template>

<xsl:template name="includeScript">
	<includeScripts>
		<xsl:for-each select = "//IncludeScript" >
			<xsl:if test="not(attr[3]/@lowerValue='generated scp - not viewable')">
			<includeScript>
			<xsl:call-template name="attr"/>
			<internal>
				<xsl:attribute name="internal">
						<xsl:value-of select="internal/@internal"/>
				</xsl:attribute>
			</internal>
			<xsl:for-each select = "description" >
				<description>
					<xsl:attribute name="line">
						<xsl:value-of select="@line"/>
					</xsl:attribute>
					<xsl:value-of select="."/>
				</description>
			</xsl:for-each>
			<xsl:call-template name="throws"/>
			<xsl:call-template name="seeAlso"/>
			</includeScript>
			</xsl:if>
		</xsl:for-each>
	</includeScripts>
</xsl:template>

<xsl:template name="GlobalConstant">
	<GlobalConstants>
		<xsl:for-each select = "//GlobalConstant" >
		<GlobalConstant>		
			<xsl:call-template name="attr"/>						
		</GlobalConstant>
		</xsl:for-each>
	</GlobalConstants>
</xsl:template> 

<xsl:template name="GlobalVariable">
	<GlobalVariables>
		<xsl:for-each select = "//GlobalVariable" >
		<GlobalVariable>		
			<xsl:call-template name="attr"/>						
		</GlobalVariable>
		</xsl:for-each>
	</GlobalVariables>
</xsl:template> 

<xsl:template name="GL3Procedure">
	<GL3Procedures>
		<xsl:for-each select = "//GL3Procedure" >
		<GL3Procedure>		
			<xsl:call-template name="attr"/>						
		</GL3Procedure>
		</xsl:for-each>
	</GL3Procedures>
</xsl:template> 

<xsl:template name="FieldTemplate">
	<FieldTemplates>
		<xsl:for-each select = "//FieldTemplate" >
		<FieldTemplate>		
			<xsl:call-template name="attr"/>
			<xsl:for-each select = "methods/method" >					
					<xsl:for-each select = "description" >
					<description>
						<xsl:attribute name="line">
							<xsl:value-of select="@line"/>
						</xsl:attribute>
						<xsl:value-of select="."/>
					</description>
					</xsl:for-each>
					<xsl:call-template name="throws"/>
					<xsl:call-template name="seeAlso"/>
			</xsl:for-each>
		</FieldTemplate>
		</xsl:for-each>
	</FieldTemplates>
</xsl:template> 

<xsl:template name="externClass">
	<externClasses>
		<xsl:for-each select = "//externClass" >
		<externClass>		
			<xsl:call-template name="attr"/>						
		</externClass>
		</xsl:for-each>
	</externClasses>
</xsl:template> 

<xsl:template name="attr">
	<xsl:for-each select = "attr" >
		<attr>
			<xsl:attribute name="name">
  	    		<xsl:value-of select="@name"/>
    	   	</xsl:attribute>
					
			<xsl:call-template name="superClass">
				<xsl:with-param name="value">
					<xsl:value-of select="@lowerValue"/>
				</xsl:with-param>
			</xsl:call-template>
						
			<xsl:choose> 
				<xsl:when test = "@name='Remark'" > 
					<xsl:value-of select="."/>
				</xsl:when> 
                <xsl:otherwise> 
					<xsl:attribute name="value">
			    		<xsl:value-of select="@value"/>
    			   	</xsl:attribute>
					<xsl:attribute name="lowerValue">
			    		<xsl:value-of select="@lowerValue"/>
    			   	</xsl:attribute>
				</xsl:otherwise >
			</xsl:choose>  				
		</attr>
	</xsl:for-each>
</xsl:template> 

<xsl:template name="superClass">
	<xsl:param name="value"/>
	<xsl:for-each select = "/application/internal/intUserClass" >
		<xsl:if test = "@name=$value" > 
			<xsl:attribute name="superClass">true</xsl:attribute>
		</xsl:if> 
	</xsl:for-each>
</xsl:template>

<xsl:template name="paramType">
	<xsl:param name="name"/>	
	<xsl:for-each select = "../../paramTypes/param" >	
		<xsl:if test="$name=@name">
			<xsl:value-of select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:template> 

<xsl:template name="returnType">
	<xsl:param name="name"/>	
	<xsl:for-each select = "../../methodScripts/methodScript">			
		<xsl:for-each select = "attr">
			<xsl:if test="@name='Name'">
				<xsl:if test="@lowerValue=$name">
					<xsl:for-each select = "../attr">										
						<xsl:if test="@name='DataType'">
							<xsl:value-of select="@value"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:for-each>
</xsl:template>

<xsl:template name="returnTypeGL4Procedure">
	<xsl:for-each select = "../../attr">		
		<xsl:if test="@name='Datatype'">
			<xsl:value-of select="@value"/>
		</xsl:if>
	</xsl:for-each>
</xsl:template>

<xsl:template name="returnName">
	<xsl:for-each select = "../../attr" >	
		<xsl:if test="@name='Name'">
			<xsl:attribute name="name">
				<xsl:value-of select="@value"/>
			</xsl:attribute>
		</xsl:if>
	</xsl:for-each>	
</xsl:template>

<xsl:template name="internal">
	<xsl:param name="name"/>
	<xsl:for-each select = "../../methods/method" >	
		<xsl:if test="@lowerName=$name">		
			<xsl:if test="@internal='true'">
				<xsl:attribute name="internal">
					<xsl:value-of select="@internal"/>
				</xsl:attribute>
			</xsl:if>
		</xsl:if>
	</xsl:for-each>	
</xsl:template>

<xsl:template name="seeAlso">
	<seeAlsos>
		<xsl:for-each select = "seeAlsos/a" >
			<seeAlso>
				<xsl:attribute name="href">
					<xsl:value-of select="@href"/>
				</xsl:attribute>
				<xsl:value-of select="."/>
			</seeAlso>
		</xsl:for-each>
	</seeAlsos>
</xsl:template>

<xsl:template name="throws">
	<throws>
		<xsl:for-each select = "throws/throw" >
			<throw>
				<xsl:attribute name="name">
					<xsl:value-of select="@name"/>
				</xsl:attribute>
				<xsl:value-of select="."/>
			</throw>
		</xsl:for-each>
	</throws>
</xsl:template>

</xsl:stylesheet>
