/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.38
 * Generated at: 2020-11-08 09:21:54 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.message;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class searchUserForm_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<title>유저 검색</title>\r\n");
      out.write("<style>\r\n");
      out.write("\t#userList {\r\n");
      out.write("\t\twidth: 100%;\r\n");
      out.write("\t}\r\n");
      out.write("\t#userList tr:hover {\r\n");
      out.write("\t\tbackground-color: lightgray;\r\n");
      out.write("\t\tcursor: pointer;\r\n");
      out.write("\t}\r\n");
      out.write("\tbody{\r\n");
      out.write("\t\tbackground: #fffcf5;\r\n");
      out.write("\t}\r\n");
      out.write("\tinput{\r\n");
      out.write("\t\tbackground: #fffcf5;\r\n");
      out.write("\t}\r\n");
      out.write("\t#nickname{\r\n");
      out.write("\t\twidth: 250px;\r\n");
      out.write("\t\theight:20px;\r\n");
      out.write("\t}\r\n");
      out.write("</style>\r\n");
      out.write("</head>\r\n");
      out.write("<body align=\"center\">\r\n");
      out.write("\t<h1>유저 검색</h1>\r\n");
      out.write("\t\t<input type ='text' id=\"nickname\" placeholder='닉네임을 입력하세요.'>\r\n");
      out.write("\t\t<input type =\"button\" id=\"searchUser\" size = '20' height=\"3\" value=\"찾기\">\r\n");
      out.write("\t\t<br>\r\n");
      out.write("\t\t<hr>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<table id=\"userList\">\r\n");
      out.write("\t\t</table>\r\n");
      out.write("<script src=\"");
      out.print( request.getContextPath() );
      out.write("/resources/js/jquery-3.5.1.min.js\"></script>\t\r\n");
      out.write("<script>\r\n");
      out.write("\t$('#searchUser').click(function() {\r\n");
      out.write("\t\tvar searchName = $('#nickname').val();\r\n");
      out.write("\t\tif(searchName == \"\") {\r\n");
      out.write("\t\t\talert('검색할 닉네임을 입력하세요.');\r\n");
      out.write("\t\t\treturn;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$.ajax({\r\n");
      out.write("\t\t\turl: 'searchUser.do',\r\n");
      out.write("\t\t\ttype: \"POST\",\r\n");
      out.write("\t\t\tdata: {nickname:searchName},\r\n");
      out.write("\t\t\tsuccess: function(data) {\r\n");
      out.write("\t\t\t\tvar table = $('#userList');\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\ttable.children().remove();\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t$.each(data, function(index, value) {\r\n");
      out.write("\t\t\t\t\tvar $tr = $('<tr>');\r\n");
      out.write("\t\t\t\t\t$tr.attr('name', 'user');\r\n");
      out.write("\t\t\t\t\t$tr.attr('onclick', 'trClick(this)');\r\n");
      out.write("\t\t\t\t\tvar $td1 = $('<td>');\r\n");
      out.write("\t\t\t\t\t$td1.text(value.id);\r\n");
      out.write("\t\t\t\t\t$td1.attr('name', 'userId');\r\n");
      out.write("\t\t\t\t\tvar $td2 = $('<td>');\r\n");
      out.write("\t\t\t\t\t$td2.text(value.nickName);\r\n");
      out.write("\t\t\t\t\t$td2.attr('name', 'userName');\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t$tr.append($td1);\r\n");
      out.write("\t\t\t\t\t$tr.append($td2);\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\ttable.append($tr);\r\n");
      out.write("\t\t\t\t});\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t});\r\n");
      out.write("\t});\r\n");
      out.write("\t\r\n");
      out.write("\tfunction trClick(tr) {\r\n");
      out.write("\t\tvar id = $(tr).children().first().text();\r\n");
      out.write("\t\tvar nickname = $(tr).children().last().text();\r\n");
      out.write("\t\topener.document.getElementById('id').value = id;\r\n");
      out.write("\t\topener.document.getElementById('nickname').value = nickname;\r\n");
      out.write("\t\tself.close();\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t$('#userList').children().click(function() {\r\n");
      out.write("\t\tvar nickname = $(this).eq(1).text();\r\n");
      out.write("\t\tconsole.log(nickname);\r\n");
      out.write("\t\t\r\n");
      out.write("\t});\r\n");
      out.write("</script>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}