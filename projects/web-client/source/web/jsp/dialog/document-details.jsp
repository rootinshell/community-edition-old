<%--
  Copyright (C) 2005 Alfresco, Inc.
 
  Licensed under the Mozilla Public License version 1.1 
  with a permitted attribution clause. You may obtain a
  copy of the License at
 
    http://www.alfresco.org/legal/license.txt
 
  Unless required by applicable law or agreed to in writing,
  software distributed under the License is distributed on an
  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
  either express or implied. See the License for the specific
  language governing permissions and limitations under the
  License.
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/alfresco.tld" prefix="a" %>
<%@ taglib uri="/WEB-INF/repo.tld" prefix="r" %>

<%@ page buffer="64kb" contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ page import="org.alfresco.web.ui.common.PanelGenerator" %>

<r:page titleId="title_file_details">

<f:view>
   
   <%-- load a bundle of properties with I18N strings --%>
   <f:loadBundle basename="alfresco.messages" var="msg"/>
   
   <h:form acceptCharset="UTF-8" id="document-details">
   
   <%-- Main outer table --%>
   <table cellspacing="0" cellpadding="2">
      
      <%-- Title bar --%>
      <tr>
         <td colspan="2">
            <%@ include file="../parts/titlebar.jsp" %>
         </td>
      </tr>
      
      <%-- Main area --%>
      <tr valign="top">
         <%-- Shelf --%>
         <td>
            <%@ include file="../parts/shelf.jsp" %>
         </td>
         
         <%-- Work Area --%>
         <td width="100%">
            <table cellspacing="0" cellpadding="0" width="100%">
               <%-- Breadcrumb --%>
               <%@ include file="../parts/breadcrumb.jsp" %>
               
               <%-- Status and Actions --%>
               <tr>
                  <td style="background-image: url(<%=request.getContextPath()%>/images/parts/statuspanel_4.gif)" width="4"></td>
                  <td bgcolor="#EEEEEE">
                  
                     <%-- Status and Actions inner contents table --%>
                     <%-- Generally this consists of an icon, textual summary and actions for the current object --%>
                     <table cellspacing="4" cellpadding="0" width="100%">
                        <tr valign="top">
                           <td width="32">
                              <img src="<%=request.getContextPath()%>/images/icons/details_large.gif" width=32 height=32>
                           </td>
                           <td>
                              <div class="mainSubTitle"><h:outputText value="#{NavigationBean.nodeProperties.name}" /></div>
                              <div class="mainTitle">
                                 <h:outputText value="#{msg.details_of}" /> '<h:outputText value="#{DocumentDetailsBean.name}" />'<r:lockIcon value="#{DocumentDetailsBean.document.nodeRef}" align="absmiddle" />
                              </div>
                              <div class="mainSubText"><h:outputText value="#{msg.location}" />: <r:nodePath value="#{DocumentDetailsBean.document.nodeRef}" breadcrumb="true" actionListener="#{BrowseBean.clickSpacePath}" /></div>
                              <div class="mainSubText"><h:outputText value="#{msg.documentdetails_description}" /></div>
                           </td>
                           <td bgcolor="#465F7D" width=1></td>
                           <td width=100 style="padding-left:2px">
                              <%-- Current object actions --%>
                              <h:outputText style="padding-left:20px" styleClass="mainSubTitle" value="#{msg.actions}" />
                              
                              <%-- checkin, checkout and undo checkout --%>
                              <a:booleanEvaluator value="#{DocumentDetailsBean.locked == false && DocumentDetailsBean.workingCopy == false}">
                                 <a:actionLink value="#{msg.checkout}" image="/images/icons/CheckOut_icon.gif" padding="4"
                                               actionListener="#{CheckinCheckoutBean.setupContentAction}" action="checkoutFile">
                                    <f:param name="id" value="#{DocumentDetailsBean.id}" />
                                 </a:actionLink>
                              </a:booleanEvaluator>
                              <a:booleanEvaluator value="#{DocumentDetailsBean.owner == true}">
                                 <a:actionLink value="#{msg.checkin}" image="/images/icons/CheckIn_icon.gif" padding="4"
                                               actionListener="#{CheckinCheckoutBean.setupContentAction}" action="checkinFile">
                                    <f:param name="id" value="#{DocumentDetailsBean.id}" />
                                 </a:actionLink>
                              </a:booleanEvaluator>
                              <a:booleanEvaluator value="#{DocumentDetailsBean.owner == true}">
                                 <a:actionLink value="#{msg.undocheckout}" image="/images/icons/undo_checkout.gif" padding="4" 
                                               actionListener="#{CheckinCheckoutBean.setupContentAction}" action="undoCheckoutFile">
                                    <f:param name="id" value="#{DocumentDetailsBean.id}" />
                                 </a:actionLink>
                              </a:booleanEvaluator>
                              
                              <%-- approve and reject --%>
                              <a:booleanEvaluator value="#{DocumentDetailsBean.approveStepName != null && DocumentDetailsBean.workingCopy == false && DocumentDetailsBean.locked == false}">
                                 <a:actionLink value="#{DocumentDetailsBean.approveStepName}" image="/images/icons/approve.gif" padding="4"
                                               actionListener="#{DocumentDetailsBean.approve}" action="browse">
                                    <f:param name="id" value="#{DocumentDetailsBean.id}" />
                                 </a:actionLink>
                              </a:booleanEvaluator>
                              <a:booleanEvaluator value="#{DocumentDetailsBean.rejectStepName != null && DocumentDetailsBean.workingCopy == false && DocumentDetailsBean.locked == false}">
                                 <a:actionLink value="#{DocumentDetailsBean.rejectStepName}" image="/images/icons/reject.gif" padding="4"
                                               actionListener="#{DocumentDetailsBean.reject}" action="browse">
                                    <f:param name="id" value="#{DocumentDetailsBean.id}" />
                                 </a:actionLink>
                              </a:booleanEvaluator>
                              
                              <a:menu itemSpacing="4" image="/images/icons/more.gif" menuStyleClass="moreActionsMenu"
                                      label="#{msg.more_options}" tooltip="#{msg.more_options_file}" style="padding-left:20px">
                                 <%-- edit and update --%>
                                 <a:booleanEvaluator value="#{(DocumentDetailsBean.locked == false && DocumentDetailsBean.workingCopy == false) || DocumentDetailsBean.owner == true}">
                                    <a:actionLink value="#{msg.edit}" image="/images/icons/edit_icon.gif"
                                                  actionListener="#{CheckinCheckoutBean.editFile}">
                                       <f:param name="id" value="#{DocumentDetailsBean.id}" />
                                    </a:actionLink>
                                    <a:actionLink value="#{msg.update}" image="/images/icons/update.gif"
                                                  actionListener="#{CheckinCheckoutBean.setupContentAction}" action="updateFile">
                                       <f:param name="id" value="#{DocumentDetailsBean.id}" />
                                    </a:actionLink>
                                 </a:booleanEvaluator>
                                 
                                 <%-- cut --%>
                                 <a:actionLink value="#{msg.cut}" image="/images/icons/cut.gif"
                                               actionListener="#{ClipboardBean.cutNode}">
                                    <f:param name="id" value="#{DocumentDetailsBean.id}" />
                                 </a:actionLink>
                                 
                                 <%-- copy --%>
                                 <a:actionLink value="#{msg.copy}" image="/images/icons/copy.gif"
                                               actionListener="#{ClipboardBean.copyNode}">
                                    <f:param name="id" value="#{DocumentDetailsBean.id}" />
                                 </a:actionLink>
                                    
                                 <%-- delete --%>
                                 <a:booleanEvaluator value="#{DocumentDetailsBean.locked == false && DocumentDetailsBean.workingCopy == false}">
                                    <a:actionLink value="#{msg.delete}" image="/images/icons/delete.gif"
                                                  actionListener="#{BrowseBean.setupContentAction}" action="deleteFile">
                                       <f:param name="id" value="#{DocumentDetailsBean.id}" />
                                    </a:actionLink>
                                 </a:booleanEvaluator>
                                 
                                 <%-- create shortcut --%>
                                 <a:actionLink value="#{msg.create_shortcut}" image="/images/icons/shortcut.gif" actionListener="#{UserShortcutsBean.createShortcut}">
                                    <f:param name="id" value="#{DocumentDetailsBean.id}" />
                                 </a:actionLink>
                                 
                                 <%-- other action --%>
                                 <a:actionLink value="#{msg.other_action}" image="/images/icons/action.gif" action="createAction" actionListener="#{NewActionWizard.startWizard}" />
                              </a:menu>
                           </td>
                           
                           <%-- Navigation --%>
                           <td bgcolor="#465F7D" width=1></td>
                           <td width=100>
                              <h:outputText style="padding-left:20px" styleClass="mainSubTitle" value="#{msg.navigation}" /><br>
                              <a:actionLink value="#{msg.next_item}" image="/images/icons/NextItem.gif" padding="4" actionListener="#{DocumentDetailsBean.nextItem}" action="nextItem">
                                 <f:param name="id" value="#{DocumentDetailsBean.id}" />
                              </a:actionLink>
                              <a:actionLink value="#{msg.previous_item}" image="/images/icons/PreviousItem.gif" padding="4" actionListener="#{DocumentDetailsBean.previousItem}" action="previousItem">
                                 <f:param name="id" value="#{DocumentDetailsBean.id}" />
                              </a:actionLink>
                           </td>
                        </tr>
                     </table>
                  </td>
                  <td style="background-image: url(<%=request.getContextPath()%>/images/parts/statuspanel_6.gif)" width="4"></td>
               </tr>
               
               <%-- separator row with gradient shadow --%>
               <tr>
                  <td><img src="<%=request.getContextPath()%>/images/parts/statuspanel_7.gif" width="4" height="9"></td>
                  <td style="background-image: url(<%=request.getContextPath()%>/images/parts/statuspanel_8.gif)"></td>
                  <td><img src="<%=request.getContextPath()%>/images/parts/statuspanel_9.gif" width="4" height="9"></td>
               </tr>
               
               <%-- Details --%>
               <tr valign=top>
                  <td style="background-image: url(<%=request.getContextPath()%>/images/parts/whitepanel_4.gif)" width="4"></td>
                  <td>
                     <table cellspacing="0" cellpadding="3" border="0" width="100%">
                        <tr>
                           <td width="100%" valign="top">
                              <a:panel label="#{msg.preview}" id="preview-panel" progressive="true"
                                       border="white" bgcolor="white" titleBorder="blue" titleBgcolor="#D3E6FE">
                                 <table width=100% cellspacing=0 cellpadding=0 border=0>
                                    <tr>
                                       <td align=left>
                                          <a:actionLink value="#{msg.view_in_browser}" href="#{DocumentDetailsBean.browserUrl}" />
                                       </td>
                                    </tr>
                                 </table>
                              </a:panel>
                              <br/>
                              <a:panel label="#{msg.properties}" id="properties-panel" progressive="true"
                                       border="white" bgcolor="white" titleBorder="blue" titleBgcolor="#D3E6FE"
                                       action="editDocProperties" linkIcon="/images/icons/Change_details.gif"
                                       actionListener="#{EditDocPropsDialog.setupDocumentForAction}"
                                       linkTooltip="#{msg.modify}" rendered="#{DocumentDetailsBean.locked == false}">
                                 <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                    <tr>
                                       <td width=80 align=center>
                                          <%-- icon image for the doc --%>
                                          <table cellspacing=0 cellpadding=0 border=0>
                                             <tr>
                                                <td>
                                                   <div style="border: thin solid #CCCCCC; padding:4px">
                                                      <a:actionLink id="doc-logo1" value="#{DocumentDetailsBean.name}" href="#{DocumentDetailsBean.url}" image="#{DocumentDetailsBean.document.properties.fileType32}" showLink="false" />
                                                   </div>
                                                </td>
                                                <td><img src="<%=request.getContextPath()%>/images/parts/rightSideShadow42.gif" width=6 height=42></td>
                                             </tr>
                                             <tr>
                                                <td colspan=2><img src="<%=request.getContextPath()%>/images/parts/bottomShadow42.gif" width=48 height=5></td>
                                             </tr>
                                          </table>
                                       </td>
                                       <td>
                                          <%-- properties for the doc --%>
                                          <r:propertySheetGrid id="document-props" value="#{DocumentDetailsBean.document}" var="documentProps" 
                                                      columns="1" mode="view" labelStyleClass="propertiesLabel" 
                                                      externalConfig="true" />
                                          <h:outputText id="no-inline-msg" value="<br/>#{msg.not_inline_editable}<br/><br/>"
                                               rendered="#{DocumentDetailsBean.inlineEditable == false}" escape="false" />
                                          <a:actionLink id="make-inline" value="#{msg.allow_inline_editing}" 
                                               action="#{DocumentDetailsBean.applyInlineEditable}"
                                               rendered="#{DocumentDetailsBean.inlineEditable == false}" />
                                          <h:messages id="props-msgs" styleClass="errorMessage" layout="table" />
                                       </td>
                                    </tr>
                                 </table>
                              </a:panel>
                              <a:panel label="#{msg.properties}" id="properties-panel-locked" progressive="true"
                                       border="white" bgcolor="white" titleBorder="blue" titleBgcolor="#D3E6FE"
                                       rendered="#{DocumentDetailsBean.locked}">
                                 <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                    <tr>
                                       <td width=80 align=center>
                                          <%-- icon image for the doc --%>
                                          <table cellspacing=0 cellpadding=0 border=0>
                                             <tr>
                                                <td>
                                                   <div style="border: thin solid #CCCCCC; padding:4px">
                                                      <a:actionLink id="doc-logo2" value="#{DocumentDetailsBean.name}" href="#{DocumentDetailsBean.url}" image="#{DocumentDetailsBean.document.properties.fileType32}" showLink="false" />
                                                   </div>
                                                </td>
                                                <td><img src="<%=request.getContextPath()%>/images/parts/rightSideShadow42.gif" width=6 height=42></td>
                                             </tr>
                                             <tr>
                                                <td colspan=2><img src="<%=request.getContextPath()%>/images/parts/bottomShadow42.gif" width=48 height=5></td>
                                             </tr>
                                          </table>
                                       </td>
                                       <td>
                                          <r:propertySheetGrid id="document-props-locked" value="#{DocumentDetailsBean.document}" var="documentProps" 
                                                      columns="1" mode="view" labelStyleClass="propertiesLabel" 
                                                      externalConfig="true" />
                                          <h:outputText id="no-inline-msg2" value="<br/>#{msg.not_inline_editable}<br/>"
                                               rendered="#{DocumentDetailsBean.inlineEditable == false}" escape="false" />
                                          <h:messages id="props-locked-msgs" styleClass="errorMessage" layout="table" />
                                       </td>
                                    </tr>
                                 </table>
                              </a:panel>
                              <br/>
                              <a:panel label="#{msg.workflow}" id="workflow-panel" progressive="true" expanded="false"
                                       border="white" bgcolor="white" titleBorder="blue" titleBgcolor="#D3E6FE"
                                       action="editSimpleWorkflow" linkIcon="/images/icons/Change_details.gif"
                                       rendered="#{DocumentDetailsBean.approveStepName != null}" linkTooltip="#{msg.workflow}">
                                 <h:outputText id="workflow-overview" value="#{DocumentDetailsBean.workflowOverviewHTML}" 
                                               escape="false" />
                              </a:panel>
                              <a:panel label="#{msg.workflow}" id="no-workflow-panel" progressive="true" expanded="false"
                                       border="white" bgcolor="white" titleBorder="blue" titleBgcolor="#D3E6FE"
                                       rendered="#{DocumentDetailsBean.approveStepName == null}">
                                 <h:outputText id="no-workflow-msg" value="#{msg.not_in_workflow}" />
                              </a:panel>
                              <br/>
                              <a:panel label="#{msg.category}" id="category-panel" progressive="true" expanded="false"
                                       border="white" bgcolor="white" titleBorder="blue" titleBgcolor="#D3E6FE"
                                       action="editCategory" actionListener="#{DocumentDetailsBean.setupCategoryForEdit}"
                                       linkIcon="/images/icons/Change_details.gif" linkTooltip="#{msg.change_category}"
                                       rendered="#{DocumentDetailsBean.categorised}">
                                 <h:outputText id="category-overview" value="#{DocumentDetailsBean.categoriesOverviewHTML}" 
                                               escape="false" />
                              </a:panel>
                              <a:panel label="#{msg.category}" id="no-category-panel" progressive="true" expanded="false"
                                       border="white" bgcolor="white" titleBorder="blue" titleBgcolor="#D3E6FE"
                                       rendered="#{DocumentDetailsBean.categorised == false}">
                                 <h:outputText id="no-category-msg" value="#{msg.not_in_category}<br/><br/>" 
                                               escape="false"/>
                                 <a:actionLink id="make-classifiable" value="#{msg.allow_categorization}" 
                                               action="#{DocumentDetailsBean.applyClassifiable}"
                                               rendered="#{DocumentDetailsBean.locked == false}" />
                              </a:panel>
                              <br/>
                              <a:panel label="#{msg.version_history}" id="version-history-panel" progressive="true" expanded="false"
                                       border="white" bgcolor="white" titleBorder="blue" titleBgcolor="#D3E6FE"
                                       rendered="#{DocumentDetailsBean.versionable}">
                                 
                                 <a:richList id="versionHistoryList" viewMode="details" value="#{DocumentDetailsBean.versionHistory}" 
                                             var="r" styleClass="recordSet" headerStyleClass="recordSetHeader" 
                                             rowStyleClass="recordSetRow" altRowStyleClass="recordSetRowAlt" width="100%" 
                                             pageSize="10" initialSortColumn="versionLabel" initialSortDescending="false">
                        
                                    <%-- Primary column for details view mode --%>
                                    <a:column id="col1" primary="true" width="100" style="padding:2px;text-align:left">
                                       <f:facet name="header">
                                          <a:sortLink label="#{msg.version}" value="versionLabel" mode="case-insensitive" styleClass="header"/>
                                       </f:facet>
                                       <a:actionLink id="label" value="#{r.versionLabel}" href="#{r.url}" />
                                    </a:column>
                                    
                                    <%-- Description columns --%>
                                    <a:column id="col2" style="text-align:left">
                                       <f:facet name="header">
                                          <a:sortLink label="#{msg.author}" value="author" styleClass="header"/>
                                       </f:facet>
                                       <h:outputText id="author" value="#{r.author}" />
                                    </a:column>
                                    
                                    <%-- Created Date column for details view mode --%>
                                    <a:column id="col3" style="text-align:left">
                                       <f:facet name="header">
                                          <a:sortLink label="#{msg.date}" value="versionDate" styleClass="header"/>
                                       </f:facet>
                                       <h:outputText id="date" value="#{r.versionDate}">
                                          <a:convertXMLDate type="both" pattern="MMMM, d yyyy HH:mm" />
                                       </h:outputText>
                                    </a:column>
                                    
                                    <%-- view the contents of the specific version --%>
                                    <a:column id="col4" style="text-align: left">
                                       <f:facet name="header">
                                          <h:outputText value="#{msg.actions}"/>
                                       </f:facet>
                                       <a:actionLink id="view-link" value="View" href="#{r.url}" />
                                    </a:column>
              
                                    <a:dataPager/>
                                 </a:richList>
                              </a:panel>
                              <a:panel label="#{msg.version_history}" id="no-version-history-panel" progressive="true" expanded="false"
                                       border="white" bgcolor="white" titleBorder="blue" titleBgcolor="#D3E6FE"
                                       rendered="#{DocumentDetailsBean.versionable == false}">
                                 <h:outputText id="no-history-msg" value="#{msg.not_versioned}<br/><br/>" 
                                               escape="false" />
                                 <a:actionLink id="make-versionable" value="#{msg.allow_versioning}"
                                               action="#{DocumentDetailsBean.applyVersionable}" 
                                               rendered="#{DocumentDetailsBean.locked == false}" />
                              </a:panel>
                              <br/>
                           </td>
                           
                           <td valign="top">
                              <% PanelGenerator.generatePanelStart(out, request.getContextPath(), "blue", "#D3E6FE"); %>
                              <table cellpadding="1" cellspacing="1" border="0">
                                 <tr>
                                    <td align="center">
                                       <h:commandButton value="#{msg.close}" action="browse" styleClass="wizardButton" />
                                    </td>
                                 </tr>
                              </table>
                              <% PanelGenerator.generatePanelEnd(out, request.getContextPath(), "blue"); %>
                           </td>
                        </tr>
                     </table>
                  </td>
                  <td style="background-image: url(<%=request.getContextPath()%>/images/parts/whitepanel_6.gif)" width="4"></td>
               </tr>
               
               <%-- separator row with bottom panel graphics --%>
               <tr>
                  <td><img src="<%=request.getContextPath()%>/images/parts/whitepanel_7.gif" width="4" height="4"></td>
                  <td width="100%" align="center" style="background-image: url(<%=request.getContextPath()%>/images/parts/whitepanel_8.gif)"></td>
                  <td><img src="<%=request.getContextPath()%>/images/parts/whitepanel_9.gif" width="4" height="4"></td>
               </tr>
               
            </table>
          </td>
       </tr>
    </table>
    
    </h:form>
    
</f:view>

</r:page>