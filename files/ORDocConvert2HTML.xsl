<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes" media-type="iso-8859-1"/>
	<!--xsl:output method="html" version="4.0" encoding = "iso-8859-1"/-->
	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:variable name="name">Name</xsl:variable>
					<xsl:for-each select="application/attr">
						<xsl:if test="@name= 'Name'">
							<xsl:value-of select="@value"/>
						</xsl:if>
					</xsl:for-each>
				</title>
				<link rel="stylesheet" href="files/ORDocStyle.css" type="text/css"/>
			</head>
			<body>
				<table width="100%" border="0">
					<tr><td class="header"><br/><xsl:value-of select="application/attr[1]/@value"/></td></tr>
					<tr><td><xsl:call-template name="interface"/></td></tr>
					<tr><td class="header">	<br/> Index</td></tr>
					<tr><td><xsl:call-template name="index"/></td></tr>
					<tr><td class="header"><br/>Classes</td></tr>
					<tr><td><xsl:call-template name="classes"/></td></tr>
					<tr><td class="header"><br/>4GL Procedures</td></tr>
					<tr><td><xsl:call-template name="GL4Procedure"/></td></tr>
					<tr><td class="header"><br/>User Frames</td></tr>
					<tr><td><xsl:call-template name="Frame"/></td>
					</tr><tr class="header"><td><br/>Ghost Frames</td></tr>
					<tr><td><xsl:call-template name="GhostFrame"/></td></tr>
					<tr class="header"><td><br/>Include scripts</td></tr>
					<tr><td><xsl:call-template name="includeScript"/></td></tr>
					<tr><td class="header"><br/>Global Variables</td></tr>
					<tr><td><xsl:call-template name="GlobalVariables"/></td></tr>
					<tr><td class="header"><br/>Global Constants</td></tr>
					<tr><td><xsl:call-template name="GlobalConstant"/></td></tr>
					<tr><td class="header"><br/>3GL Procedures</td></tr>
					<tr><td><xsl:call-template name="GL3Procedure"/></td></tr>
					<tr><td class="header"><br/>Field Templates</td></tr>
					<tr><td><xsl:call-template name="FieldTemplate"/></td></tr>
					<tr><td class="header"><br/>External Classes</td></tr>
					<tr><td><xsl:call-template name="externClass"/></td></tr>
				</table>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="index">
		<xsl:for-each select="/*/*/*/attr">
			<xsl:sort select="@value"/>
			<xsl:if test="@name='Name'">
				<xsl:if test="not(../../../@name='')">
					<a class="paragraph">
						<xsl:attribute name="href">
			#<xsl:value-of select="../../../@name"/>.<xsl:value-of select="@lowerValue"/></xsl:attribute>
						<xsl:value-of select="@value"/>
					</a>,
			</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="interface">
		<table border="0" width="100%" class="paragraph">
			<tr>
				<td class="label">Version</td>
				<td class="paragraph">
					<xsl:value-of select="application/attr[2]/@value"/>
				</td>
			</tr>
			<tr>
				<td class="label">Short remark</td>
				<td class="paragraph">
					<xsl:value-of select="application/attr[3]/@value"/>
				</td>
			</tr>
			<tr>
				<td class="label">Alter date</td>
				<td class="paragraph">
					<xsl:value-of select="application/attr[9]/@value"/>
				</td>
			</tr>
			<tr>
				<td class="label">Alter count</td>
				<td class="paragraph">
					<xsl:value-of select="application/attr[10]/@value"/>
				</td>
			</tr>
			<tr>
				<td class="label">Start frame</td>
				<td class="paragraph">
					<xsl:value-of select="application/attr[11]/@value"/>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template name="classes">
		<xsl:for-each select="application/userClasses/userClass">
			<xsl:sort select="attr[1]/@value"/>
			<xsl:if test="not((methods/method[1]/@internal='true') and (methods/method[1]/@name=''))">
			<a>
				<xsl:attribute name="name"><xsl:value-of select="../../@name"/>.<xsl:value-of select="attr[1]/@lowerValue"/></xsl:attribute>
			</a>
			<table border="0" width="100%" class="bodybackground">
				<tr>
					<td>
						<table border="0" width="100%" class="main">
							<tr>
								<td class="labelnewrow" width="150px">Name</td>
								<td class="textnewrow">
									<xsl:value-of select="attr[1]/@value"/>
								</td>
							</tr>
							<tr>
								<td class="label">Version</td>
								<td class="paragraph">
									<xsl:value-of select="attr[2]/@value"/>
								</td>
							</tr>
							<tr>
								<td class="label">Short remark</td>
								<td class="paragraph">
									<xsl:value-of select="attr[3]/@value"/>
								</td>
							</tr>
							<tr>
								<td class="label">Alter date</td>
								<td class="paragraph">
									<xsl:value-of select="attr[9]/@value"/>
								</td>
							</tr>
							<tr>
								<td class="label">Superclass</td>
								<td class="paragraph">
									<xsl:choose>
										<xsl:when test="attr[13]/@superClass='true'">
											<a>
												<xsl:attribute name="href">
				    		#<xsl:value-of select="/application/@name"/>.<xsl:value-of select="attr[13]/@lowerValue"/></xsl:attribute>
												<xsl:value-of select="attr[13]/@value"/>
											</a>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="attr[13]/@value"/>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<div class="paragraph">
							<xsl:for-each select="methods/method">
								
									<xsl:if test="@name=''">
										<xsl:for-each select="description">
											<xsl:value-of select="." disable-output-escaping="yes"/>
											<br/>
										</xsl:for-each>
										<xsl:if test="count(throws/throw)>0">
											<table border="0" cellspacing="0">
												<tr><td class="main">Throws</td></tr>
												<tr><td class="paragraph"><xsl:call-template name="throws"/></td></tr>
											</table>
										</xsl:if>
										<xsl:if test="count(seeAlsos/seeAlso)>0">
											<table border="0" cellspacing="0">
												<tr><td class="main">See also</td></tr>
												<tr><td class="paragraph"><xsl:call-template name="seeAlso"/></td></tr>
											</table>
										</xsl:if>
										<br/>
									</xsl:if>
								
							</xsl:for-each>
						</div>
					</td>
				</tr>
				<xsl:if test="count(attributeObjects/attributeObject)>0">
					<tr>
						<td>
							<table border="0" width="100%" class="main">
								<tr><td align="center" class="main">Attributes</td></tr>
							</table>
						</td>
					</tr>
				</xsl:if>
				<tr>
					<td>
						<table border="0" width="100%" class="main">
							<xsl:if test="not(count(attributeObjects/attributeObject)=0)">
								<tr>
									<th width="16%" class="label">Name</th>
									<th width="16%" class="label">Datatype</th>
									<th width="50%" class="label">Description</th>
									<th width="7%" class="label">Scope</th>
									<th class="label">Default</th>
								</tr>
							</xsl:if>
							<xsl:for-each select="attributeObjects/attributeObject">
								<xsl:sort select="attr[1]/@value"/>
								<xsl:if test="not(@internal='true')">
									<tr>
										<td class="paragraph">
											<xsl:value-of select="attr[1]/@value"/>
										</td>
										<td class="paragraph">
											<xsl:value-of select="attr[2]/@value"/>
											<xsl:if test="attr[3]/@lowerValue='true'">
				[]
			</xsl:if>
											<xsl:call-template name="isALink">
												<xsl:with-param name="name">
													<xsl:value-of select="attr[2]/@lowerValue"/>
												</xsl:with-param>
											</xsl:call-template>
										</td>
										<td class="paragraph">
											<xsl:for-each select="attrs/attr">
												<xsl:value-of select="." disable-output-escaping="yes"/>
												<br/>
											</xsl:for-each>
										</td>
										<td class="paragraph">
											<xsl:if test="attr[4]/@lowerValue='true'">
				Protected
				</xsl:if>
										</td>
										<td class="paragraph">
											<xsl:if test="attr[7]/@value='TRUE'">				
				Null
			</xsl:if>
											<xsl:if test="not(attr[7]/@value='TRUE')">
												<xsl:value-of select="attr[6]/@value"/>
											</xsl:if>
										</td>
									</tr>
								</xsl:if>							
							</xsl:for-each>
						</table>
					</td>
				</tr>
				<xsl:if test="count(methodScripts/methodScript)>0">
					<tr>
						<td>
							<table border="0" width="100%" class="main">
								<tr>
									<td align="center" class="main">Methods summary</td>
								</tr>
							</table>
						</td>
					</tr>
				</xsl:if>
				<tr>
					<td>
						<table border="0" width="100%" class="main">
							<xsl:if test="count(methodScripts/methodScript)>0">
								<tr>
									<th width="16%" class="label">Name</th>
									<th width="16%" class="label">Returntype</th>
									<th width="50%" class="label">Description</th>
									<th width="7%" class="label">Scope</th>
									<th class="label">Default</th>
								</tr>
							</xsl:if>
							<xsl:for-each select="methodScripts/methodScript">
								<xsl:sort select="attr[1]/@value"/>
								<xsl:if test="not(@internal='true')">
									<tr>
										<td class="paragraph" valign="top">
											<a>
												<xsl:attribute name="href">
						#<xsl:value-of select="../../attr[1]/@lowerValue"/>.<xsl:value-of select="attr[1]/@lowerValue"/></xsl:attribute>
												<xsl:value-of select="attr[1]/@value"/>
											</a>
										</td>
										<td class="paragraph" valign="top">
											<xsl:value-of select="attr[2]/@value"/>
											<xsl:if test="attr[3]/@lowerValue='true'">
				[]
			</xsl:if>
											<xsl:call-template name="isALink">
												<xsl:with-param name="name">
													<xsl:value-of select="attr[2]/@lowerValue"/>
												</xsl:with-param>
											</xsl:call-template>
										</td>
										<td class="paragraph">
											<xsl:for-each select="attrs/attr">
												<xsl:value-of select="." disable-output-escaping="yes"/>
												<br/>
											</xsl:for-each>
										</td>
										<td class="paragraph"><xsl:if test="attr[4]/@lowerValue='true'">Protected</xsl:if></td>
										<td class="paragraph"><xsl:if test="attr[5]/@value='TRUE'">Null</xsl:if></td>
									</tr>
								</xsl:if>
							</xsl:for-each>
						</table>
					</td>
				</tr>
				<xsl:if test="count(methods/method)>0">
					<tr><td>
							<table border="0" width="100%" class="main">
								<tr><td align="center">Methods Detail</td></tr>
							</table>
						</td></tr>
					<tr><td>
							<xsl:call-template name="procedureMethodDetail">
								<xsl:with-param name="name">
									<xsl:value-of select="attr[1]/@lowerValue"/>
								</xsl:with-param>
							</xsl:call-template>
						</td></tr>
				</xsl:if>
				<tr><td></td></tr>
			</table>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="GL4Procedure">
		<xsl:for-each select="application/GL4Procedures/GL4Procedure">
			<a><xsl:attribute name="name"><xsl:value-of select="../../@name"/>.<xsl:value-of select="attr[1]/@lowerValue"/></xsl:attribute></a>
			<xsl:call-template name="printFrames"/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="Frame">
		<xsl:for-each select="application/frames/frame">
			<a><xsl:attribute name="name"><xsl:value-of select="../../@name"/>.<xsl:value-of select="attr[1]/@lowerValue"/></xsl:attribute></a>
			<xsl:call-template name="printFrames"/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="GhostFrame">
		<xsl:for-each select="application/ghostFrames/ghostFrame">
			<a><xsl:attribute name="name"><xsl:value-of select="../../@name"/>.<xsl:value-of select="attr[1]/@lowerValue"/></xsl:attribute></a>
			<xsl:call-template name="printFrames"/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="includeScript">
		<xsl:for-each select="application/includeScripts/includeScript">
			<xsl:if test="not(attr[21]/@value='TRUE')">
				<a><xsl:attribute name="name"><xsl:value-of select="../../@name"/>.<xsl:value-of select="attr[1]/@lowerValue"/></xsl:attribute></a>
				<table border="0" width="100%" class="bodybackground">
					<tr><td>
							<table border="0" width="100%" class="main">
								<tr>
									<td class="labelnewrow" width="150px">Name</td>
									<td class="textnewrow"><xsl:value-of select="attr[1]/@value"/></td>
								</tr>
								<tr>
									<td class="label">Version</td>
									<td class="paragraph"><xsl:value-of select="attr[2]/@value"/></td>
								</tr>
								<tr>
									<td class="label">Short remark</td>
									<td class="paragraph"><xsl:value-of select="attr[3]/@value"/></td>
								</tr>
								<tr>
									<td class="label">Alter date</td>
									<td class="paragraph"><xsl:value-of select="attr[9]/@value"/></td>
								</tr>
							</table>
						</td></tr>
					<tr><td>
							<xsl:if test="not(internal/@internal='true')">
								<table border="0" width="100%" class="main">
									<tr>
										<td class="paragraph">
											<xsl:for-each select="description">
												<xsl:value-of select="." disable-output-escaping="yes"/>
												<br/>
											</xsl:for-each>
										</td>
									</tr>
								</table>
							</xsl:if>
						</td>
					</tr>
					<tr><td>
							<table border="0" width="100%" class="main">
								<tr><td>See also</td></tr>
								<xsl:for-each select="seeAlsos/seeAlso">
									<tr><td class="paragraph">
										<a><xsl:attribute name="href"><xsl:value-of select="@see"/></xsl:attribute><xsl:value-of select="."/></a>
									</td></tr>
								</xsl:for-each>
							</table>
						</td>
					</tr>
				</table>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="GlobalVariables">
		<table border="0" width="100%" class="bodybackground">
			<xsl:if test="count(application/GlobalVariables/GlobalVariable)>0">
				<tr>
					<th width="16%" class="label">Name</th>
					<th width="16%" class="label">Datatype</th>
					<th width="50%" class="label">Description</th>
					<th class="label">Value</th>
				</tr>
			</xsl:if>
			<xsl:for-each select="application/GlobalVariables/GlobalVariable">
				<tr><xsl:call-template name="globalVarConst"/></tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	<xsl:template name="GlobalConstant">
		<table border="0" width="100%" class="bodybackground">
			<xsl:if test="count(application/GlobalConstants/GlobalConstant)>0">
				<tr>
					<th width="16%" class="label">Name</th>
					<th width="16%" class="label">Datatype</th>
					<th width="50%" class="label">Description</th>
					<th class="label">Value</th>
				</tr>
			</xsl:if>
			<xsl:for-each select="application/GlobalConstants/GlobalConstant">
				<tr><xsl:call-template name="globalVarConst"/></tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	<xsl:template name="GL3Procedure">
		<table border="0" width="100%" class="bodybackground">
			<xsl:if test="count(application/GL3Procedures/GL3Procedure)>0">
				<tr>
					<th width="16%" class="label">Name</th>
					<th width="16%" class="label">Datatype</th>
					<th class="label">Description</th>
				</tr>
			</xsl:if>
			<xsl:for-each select="application/GL3Procedures/GL3Procedure">
				<tr>
					<td class="paragraph">
						<a><xsl:attribute name="name"><xsl:value-of select="attr[11]/@lowerValue"/>.<xsl:value-of select="attr[1]/@lowerValue"/></xsl:attribute></a>
						<xsl:value-of select="attr[1]/@value"/>
					</td>
					<td class="paragraph"><xsl:value-of select="attr[13]/@value"/></td>
					<td class="paragraph"><xsl:value-of select="attr[3]/@value"/></td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	<xsl:template name="FieldTemplate">
	<xsl:for-each select="application/FieldTemplates/FieldTemplate">
			<xsl:if test="not(attr[21]/@value='TRUE')">
				<a><xsl:attribute name="name"><xsl:value-of select="../../@name"/>.<xsl:value-of select="attr[1]/@lowerValue"/></xsl:attribute></a>
				<table border="0" width="100%" class="bodybackground">
					<tr><td>
							<table border="0" width="100%" class="main">
								<tr>
									<td class="labelnewrow" width="150px">Name</td>
									<td class="textnewrow"><xsl:value-of select="attr[1]/@value"/></td>
								</tr>
								<tr>
									<td class="label">Version</td>
									<td class="paragraph"><xsl:value-of select="attr[2]/@value"/></td>
								</tr>
								<tr>
									<td class="label">Short remark</td>
									<td class="paragraph"><xsl:value-of select="attr[3]/@value"/></td>
								</tr>
								<tr>
									<td class="label">Alter date</td>
									<td class="paragraph"><xsl:value-of select="attr[9]/@value"/></td>
								</tr>
							</table>
						</td></tr>
					<tr><td>
							<xsl:if test="not(internal/@internal='true')">
								<table border="0" width="100%" class="main">
									<tr>
										<td class="paragraph">
											<xsl:for-each select="description">
												<xsl:value-of select="." disable-output-escaping="yes"/>
												<br/>
											</xsl:for-each>
										</td>
									</tr>
								</table>
							</xsl:if>
						</td>
					</tr>
					<tr><td>
							<table border="0" width="100%" class="main">
								<tr><td>See also</td></tr>
								<xsl:for-each select="seeAlsos/seeAlso">
									<tr><td class="paragraph">
										<a><xsl:attribute name="href"><xsl:value-of select="@see"/></xsl:attribute><xsl:value-of select="."/></a>
									</td></tr>
								</xsl:for-each>
							</table>
						</td>
					</tr>
				</table>
			</xsl:if>














		<!-- table border="0" width="100%" class="bodybackground">
			<xsl:if test="count(application/FieldTemplates/FieldTemplate)>0">
				<table border="0" width="100%" class="bodybackground">
					<tr>
						<td>
							<table border="0" width="100%" class="main">
								<tr>
									<td class="labelnewrow" width="150px">Name</td>
									<td class="textnewrow"><xsl:value-of select="attr[1]/@value"/></td>
								</tr>
								<tr>
									<td class="label">Version</td>
									<td class="paragraph"><xsl:value-of select="attr[2]/@value"/></td>
							</tr>
							<tr>
								<td class="label">Short remark</td>
								<td class="paragraph"><xsl:value-of select="attr[3]/@value"/></td>
							</tr>
							<tr>
								<td class="label">Alter date</td>
								<td class="paragraph"><xsl:value-of select="attr[9]/@value"/></td>
							</tr>
							</table>
					</td>
					</tr>
				<tr>
					<td class="paragraph">
							<a><xsl:attribute name="name"><xsl:value-of select="../../@name"/>.<xsl:value-of select="attr[1]/@lowerValue"/></xsl:attribute></a>
							<xsl:value-of select="attr[1]/@value"/>
					</td>
					<td class="paragraph"><xsl:value-of select="attr[3]/@value"/></td>
				</tr>
					<tr>
						<td colspan="2" class="paragraph">
							<table border="0" width="100%" cellspacing="0" class="bodybackground">
								<xsl:for-each select="methods/method">
									<xsl:if test="@name=''">
										<xsl:for-each select="description">
											<tr>
												<td class="paragraph"><xsl:value-of select="." disable-output-escaping="yes"/><br/></td>
											</tr>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test="count(throws/throw)>0">
										<tr><td class="main">Throws</td></tr>
										<tr><td class="paragraph"><xsl:call-template name="throws"/></td></tr>
									</xsl:if>
									<xsl:if test="count(seeAlsos/seeAlso)>0">
										<tr><td class="main">See also</td></tr>
										<tr><td class="paragraph"><xsl:call-template name="seeAlso"/></td></tr>
									</xsl:if>
								</xsl:for-each>
							</table>
						</td>
					</tr>
-->
				</xsl:for-each>
		</xsl:template>

	<xsl:template name="externClass">
		<table border="0" width="100%" class="bodybackground">
			<xsl:if test="count(application/externClasses/externClass)>0">
				<tr>
					<th width="16%" class="label">Name</th>
					<th class="label">Description</th>
				</tr>
			</xsl:if>
			<xsl:for-each select="application/externClasses/externClass">
				<tr>
					<td class="paragraph">
						<a><xsl:attribute name="name"><xsl:value-of select="attr[11]/@lowerValue"/>.<xsl:value-of select="attr[1]/@lowerValue"/></xsl:attribute></a>
						<xsl:value-of select="attr[1]/@value"/>
					</td>
					<td class="paragraph"><xsl:value-of select="attr[3]/@value"/></td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	<xsl:template name="nameValue">
		<tr>
			<td class="label"><xsl:value-of select="@name"/></td>
			<td class="paragraph"><xsl:value-of select="@value"/></td>
		</tr>
	</xsl:template>
	<xsl:template name="paramDescription">
		<xsl:param name="variable"/>
		<xsl:for-each select="../../params/param">
			<xsl:if test="@name=$variable">
				<xsl:value-of select="."/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="findType">
		<xsl:param name="variable"/>
		<xsl:for-each select="../../../../inputParams/inputParam">
			<xsl:if test="@variable=$variable">
				<xsl:value-of select="@type"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="findReturnType">
		<xsl:param name="method"/>
		<xsl:for-each select="../../componentMethods/componentMethod">
			<xsl:for-each select="attr">
				<xsl:if test="@name='Name'">
					<xsl:if test="@value=$method">
						<xsl:call-template name="findDataType"/>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="findDataType">
		<xsl:for-each select="../attr">
			<xsl:if test="@name='DataType'">
				<xsl:value-of select="@value"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="findDataType1">
		<xsl:for-each select="../../attr">
			<xsl:if test="@name='Datatype'">
				<xsl:value-of select="@value"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="findDataType2">
		<xsl:for-each select="attr">
			<xsl:if test="@name='Datatype'">
				<xsl:value-of select="@value"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="procedureMethodDetail">
		<xsl:param name="name"/>
		<xsl:for-each select="methods/method">
			<xsl:sort select="@name"/>
			<xsl:if test="not(@name='')">
				<xsl:if test="not(@internal='true')">
					<table border="0" width="100%" class="paragraph">
						<tr>
							<td colspan="2" class="label" align="left" valign="top">
								<xsl:if test="not($name='')">
									<a><xsl:attribute name="name"><xsl:value-of select="$name"/>.<xsl:value-of select="@lowerName"/></xsl:attribute></a>
								</xsl:if>
								<xsl:value-of select="@name"/>
								<span class="paragraph">(<xsl:for-each select="inputParams/inputParam">
										<xsl:value-of select="@name"/><xsl:if test="not(position()=last())">, </xsl:if></xsl:for-each>)
								</span>
							</td>
						</tr>
						<tr>
							<td width="10px"/>
							<td>
								<xsl:for-each select="description">
									<xsl:value-of select="." disable-output-escaping="yes"/><br/>
								</xsl:for-each>
							</td>
						</tr>
					</table>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">
						<tr><td class="paragraph"><span style="width:10px;height:2px;overflow:hidden"/></td></tr>
					</table>
					<table border="0" width="100%" class="paragraph">
						<xsl:if test="not(count(inputParams/inputParam)=0)">
							<tr>
								<th width="16%" class="label">Name</th>
								<th width="16%" class="label">Datatype</th>
								<th class="label">Description</th>
							</tr>
							<xsl:for-each select="inputParams/inputParam">
								<tr>
									<td class="paragraph" valign="top"><xsl:value-of select="@name"/></td>
									<td class="paragraph" valign="top"><xsl:value-of select="paramType/."/></td>
									<td class="paragraph"><xsl:for-each select="description">
											<xsl:value-of select="." disable-output-escaping="yes"/><br/></xsl:for-each>
									</td>
								</tr>
							</xsl:for-each>
						</xsl:if>
						<tr><td colspan="3" style="height:5px;overflow:hidden" class="main"></td></tr>
						<xsl:if test="not(count(return/description)=0)">
							<xsl:if test="count(inputParams/inputParam)=0">
								<tr>
									<th width="16%" class="label"/>
									<th width="16%" class="label">Datatype</th>
									<th class="label">Description</th>
								</tr>
							</xsl:if>
							<tr>
								<td class="label" valign="top">Return</td>
								<td class="paragraph"><xsl:value-of select="return/returnType/."/></td>
								<td class="paragraph"><xsl:for-each select="return/description">
										<xsl:value-of select="." disable-output-escaping="yes"/><br/></xsl:for-each>
								</td>
							</tr>
						</xsl:if>
					</table>
					<table border="0" width="100%" class="paragraph">
						<tr><td><xsl:if test="count(throws/throw)>0">
									<table border="0" cellspacing="0">
										<tr><td class="main">Throws</td></tr>
										<tr><td class="paragraph"><xsl:call-template name="throws"/></td></tr>
									</table>
						</xsl:if></td></tr>
						<tr><td><xsl:if test="count(seeAlsos/seeAlso)>0">
									<table border="0" cellspacing="0">
										<tr><td class="main">See also</td></tr>
										<tr><td class="paragraph"><xsl:call-template name="seeAlso"/></td></tr>
									</table>
						</xsl:if></td></tr>
					</table>
					<table border="0" width="100%" class="bodybackground">
						<tr><td></td></tr>
					</table>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="printFrames">
		<table border="0" width="100%" class="bodybackground">
			<tr><td>
					<table border="0" width="100%" class="main">
						<xsl:for-each select="attr">
							<xsl:choose>
								<xsl:when test="position()=1">
									<tr>
										<td class="labelnewrow" width="150px"><xsl:value-of select="@name"/></td>
										<td class="textnewrow"><xsl:value-of select="@value"/></td>
									</tr>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="@name='Version'"><xsl:call-template name="nameValue"/></xsl:when>
										<xsl:when test="@name='Short Remark (Obj)'"><xsl:call-template name="nameValue"/></xsl:when>
										<xsl:when test="@name='Alter Date'"><xsl:call-template name="nameValue"/></xsl:when>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<xsl:for-each select="methods/method">
						<xsl:if test="@name=''">
							<div class="paragraph">
								<xsl:for-each select="description">
									<xsl:value-of select="." disable-output-escaping="yes"/><br/>
								</xsl:for-each>
							</div>
							<table border="0" width="100%" class="main">
								<xsl:if test="(count(inputParams/inputParam)>0) or (not(return/returnType/.=''))">
									<tr>
										<th width="16%" class="label">Name</th>
										<th width="16%" class="label">Datatype</th>
										<th class="label">Description</th>
									</tr>
								</xsl:if>
								<xsl:for-each select="inputParams/inputParam">
									<tr>
										<td class="paragraph"><xsl:value-of select="@name"/></td>
										<td class="paragraph"><xsl:value-of select="paramType/." disable-output-escaping="yes"/></td>
										<td class="paragraph">
											<xsl:for-each select="description">
												<xsl:value-of select="." disable-output-escaping="yes"/><br/>
											</xsl:for-each></td>
									</tr>
								</xsl:for-each>
								<xsl:if test="not(return/returnType/.='')">
									<xsl:for-each select="return">
										<tr>
											<td width="16%" class="label" valign="top">Return</td>
											<td width="16%" class="paragraph">
												<xsl:value-of select="returnType/."/>
											</td>
											<td class="paragraph">
												<xsl:for-each select="description">
													<xsl:value-of select="." disable-output-escaping="yes"/><br/>
												</xsl:for-each>
											</td>
										</tr>
									</xsl:for-each>
								</xsl:if>
								<tr>
									<td colspan="4">
										<xsl:if test="count(throws/throw)>0">
											<table border="0" cellspacing="0" class="main">
												<tr><td class="main">Throws</td></tr>
												<tr><td class="paragraph"><xsl:call-template name="throws"/></td></tr>
											</table>
										</xsl:if>
									</td>
								</tr>
								<tr>
									<td colspan="4">
										<xsl:if test="count(seeAlsos/seeAlso)>0">
											<table border="0" cellspacing="0" class="main">
												<tr><td class="main">See also</td></tr>
												<tr><td class="paragraph"><xsl:call-template name="seeAlso"/></td></tr>
											</table>
										</xsl:if>
									</td>
								</tr>
							</table>
						</xsl:if>
					</xsl:for-each>
				</td>
			</tr>
			<tr>
				<td>
					<xsl:if test="count(methods/method)>0">
						<xsl:if test="not(descriptions/@internal='true')">
							<xsl:call-template name="procedureMethodDetail"/>
						</xsl:if>
					</xsl:if>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template name="globalVarConst">
		<td class="paragraph">
			<a><xsl:attribute name="name"><xsl:value-of select="attr[11]/@lowerValue"/>.<xsl:value-of select="attr[1]/@lowerValue"/></xsl:attribute></a>
			<xsl:value-of select="attr[1]/@value"/>
		</td>
		<td class="paragraph"><xsl:value-of select="attr[13]/@value"/></td>
		<td class="paragraph"><xsl:value-of select="attr[3]/@value"/></td>
		<td class="paragraph"><xsl:value-of select="attr[15]/@value"/></td>
	</xsl:template>
	<xsl:template name="isALink">
		<xsl:param name="name"/>
		<xsl:for-each select="/*/*/*/attr">
			<xsl:if test="@name='Name'">
				<xsl:if test="@lowerValue=$name">
					<a><xsl:attribute name="href">
						#<xsl:value-of select="../../../@name"/>.<xsl:value-of select="@lowerValue"/></xsl:attribute>&gt;
					</a>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="seeAlso">
		<table border="0" cellspacing="0">
			<tr>
				<xsl:for-each select="seeAlsos/seeAlso">
					<td class="paragraph">
						<a>
							<xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
							<xsl:value-of select="." disable-output-escaping="yes"/>
						</a>
						<xsl:value-of select="@href"/>
					</td>
					<td width="5px"></td>
				</xsl:for-each>
			</tr>
		</table>
	</xsl:template>
	
	<xsl:template name="throws">
		<table border="0" cellspacing="0">
			<xsl:for-each select="throws/throw">
				<tr>
					<td class="paragraph"><xsl:value-of select="@name"/></td>
					<td><xsl:value-of select="." disable-output-escaping="yes"/></td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
</xsl:stylesheet>
