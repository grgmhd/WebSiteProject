<%@page import="java.net.URLEncoder"%>
<%@page import="util.BoardPage"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@page import="model.projectboard.ProjectBoardDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String boardName = request.getParameter("boardName");
System.out.println(boardName);

//DAO 객체 생성 및 DB연결
projectboardDAO dao = new projectboardDAO(application);
//검색어가 있는 경우 파라미터를 저장하기 위한 Map컬렉션 생성
Map<String,Object> param =new HashMap<String,Object>();
//검색 파라미터를 request 내장객체를 통해 얻어온다.
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
//검색어가 있는 경우에만
if(searchWord !=null){
	//Map컬렉션에 파라미터 값을 추가한다.
	param.put("searchField", searchField);//검색필드명(title,content 등)
	param.put("searchWord", searchWord);//검색어
}


//String boardName = request.getParameter("boardName"); //플래그 값여기서 받음 플래그 시작!!!
//param.put("boardName", boardName);


//board테이블에 저장된 게시물의 갯수 카운트
int totalCount = dao.selectCount(param, boardName);

/***페이지 처리 start***/
//컨텍스트 초기화 파라미터를 얻어온 후 사칙연산을 위한 정수로 변경한다.
int pageSize=Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage=Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
//전체 페이지 수를 계산한다. 소수점을 얻기 위해 double로 형변환 후 나눈다.
int totalPage= (int)Math.ceil((double)totalCount/pageSize);
/*  
목록에 첫 진입시에는 페이지 관련 파라미터가 없으므로 무조건 1page로 지정한다.
만약 pageNum이 있다면 파라미터를 받아와서 정수로 변경한 후 페이지수로 지정한다.
*/
int pageNum=1;
//pageTemp에 잠깐 저장
String pageTemp = request.getParameter("pageNum");
if(pageTemp != null&&!pageTemp.equals(""))
	pageNum=Integer.parseInt(pageTemp);
//게시물의 구간을 계산한다.
int start=(pageNum-1)*pageSize+1;//구간의 시작
int end=pageNum*pageSize;//구간의 끝
param.put("start",start);//Map컬렉션에 저장 후 DAO로 전달함
param.put("end", end);
/***페이지 처리 end***/
//출력할 레코드 추출
List<ProjectBoardDTO> boardLists = dao.selectList(param, boardName);
//DB작업 끝났으므로 자원 해제
dao.close();

%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>인원관리</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.jsp">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">SB Admin <sup>2</sup></div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item">
                <a class="nav-link" href="index.jsp">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Dashboard</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Interface
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-fw fa-cog"></i>
                    <span>게시판관리</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">게시판 관리</h6>
                        <a class="collapse-item" href="board_list03.jsp?boardName=not">공지사항</a>
                        <a class="collapse-item" href="board_list03.jsp?boardName=fre">Buttons</a>
                        <a class="collapse-item" href="board_list03.jsp?boardName=fre">자유게시판</a>
                        <a class="collapse-item" href="gallery_list.jsp?boardName=gal">사진게시판</a>
                        <a class="collapse-item" href="board_list03.jsp?boardName=ref">정보자료실</a>
                        <h6 class="collapse-header">커뮤니티 관리</h6>
                        <a class="collapse-item" href="board2_list.do?boardName=emp">직원자료실</a>
                        <a class="collapse-item" href="board2_list.do?boardName=prt">보호자 게시판</a>
                    </div>
                </div>
            </li>

            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item active">
                <a class="nav-link" href="#" data-toggle="collapse" data-target="#collapseUtilities"
                    aria-expanded="true" aria-controls="collapseUtilities">
                    <i class="fas fa-fw fa-wrench"></i>
                    <span>Utilities</span>
                </a>
                <div id="collapseUtilities" class="collapse show" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Custom Utilities:</h6>
                        <a class="collapse-item active" href="utilities-color.jsp">인원관리</a>
                        <a class="collapse-item" href="utilities-border.jsp">Borders</a>
                        <a class="collapse-item" href="utilities-animation.jsp">Animations</a>
                        <a class="collapse-item" href="utilities-other.jsp">Other</a>
                    </div>
                </div>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Addons
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
                    aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>Pages</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Login Screens:</h6>
                        <a class="collapse-item" href="login.jsp">Login</a>
                        <a class="collapse-item" href="register.jsp">Register</a>
                        <a class="collapse-item" href="forgot-password.jsp">Forgot Password</a>
                        <div class="collapse-divider"></div>
                        <h6 class="collapse-header">Other Pages:</h6>
                        <a class="collapse-item" href="404.jsp">404 Page</a>
                        <a class="collapse-item" href="blank.jsp">Blank Page</a>
                    </div>
                </div>
            </li>

            <!-- Nav Item - Charts -->
            <li class="nav-item">
                <a class="nav-link" href="charts.jsp">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span>Charts</span></a>
            </li>

            <!-- Nav Item - Tables -->
            <li class="nav-item">
                <a class="nav-link" href="tables.jsp">
                    <i class="fas fa-fw fa-table"></i>
                    <span>Tables</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Search -->
                    <form
                        class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                                aria-label="Search" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </form>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                        <li class="nav-item dropdown no-arrow d-sm-none">
                            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-search fa-fw"></i>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                aria-labelledby="searchDropdown">
                                <form class="form-inline mr-auto w-100 navbar-search">
                                    <div class="input-group">
                                        <input type="text" class="form-control bg-light border-0 small"
                                            placeholder="Search for..." aria-label="Search"
                                            aria-describedby="basic-addon2">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="button">
                                                <i class="fas fa-search fa-sm"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </li>

                        <!-- Nav Item - Alerts -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                <!-- Counter - Alerts -->
                                <span class="badge badge-danger badge-counter">3+</span>
                            </a>
                            <!-- Dropdown - Alerts -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header">
                                    Alerts Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-primary">
                                            <i class="fas fa-file-alt text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 12, 2019</div>
                                        <span class="font-weight-bold">A new monthly report is ready to download!</span>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-success">
                                            <i class="fas fa-donate text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 7, 2019</div>
                                        $290.29 has been deposited into your account!
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-warning">
                                            <i class="fas fa-exclamation-triangle text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 2, 2019</div>
                                        Spending Alert: We've notd unusually high spending for your account.
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                            </div>
                        </li>

                        <!-- Nav Item - Messages -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-envelope fa-fw"></i>
                                <!-- Counter - Messages -->
                                <span class="badge badge-danger badge-counter">7</span>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="messagesDropdown">
                                <h6 class="dropdown-header">
                                    Message Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="img/undraw_profile_1.svg"
                                            alt="...">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div class="font-weight-bold">
                                        <div class="text-truncate">Hi there! I am wondering if you can help me with a
                                            problem I've been having.</div>
                                        <div class="small text-gray-500">Emily Fowler · 58m</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="img/undraw_profile_2.svg"
                                            alt="...">
                                        <div class="status-indicator"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">I have the photos that you ordered last month, how
                                            would you like them sent to you?</div>
                                        <div class="small text-gray-500">Jae Chun · 1d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="img/undraw_profile_3.svg"
                                            alt="...">
                                        <div class="status-indicator bg-warning"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Last month's report looks great, I am very happy with
                                            the progress so far, keep up the good work!</div>
                                        <div class="small text-gray-500">Morgan Alvarez · 2d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60"
                                            alt="...">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Am I a good boy? The reason I ask is because someone
                                            told me that people say this to all dogs, even if they aren't good...</div>
                                        <div class="small text-gray-500">Chicken the Dog · 2w</div>
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
                            </div>
                        </li>

                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=session.getAttribute("UserName") %></span>
                                <img class="img-profile rounded-circle"
                                    src="img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Settings
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Activity Log
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">
<!-- Page Heading -->
                    <%			
					if(boardName==null || boardName.equals("not")) {
					%>
                    <h1 class="h3 mb-2 text-gray-800">공지사항 게시판</h1>
                    <p class="mb-4">공지사항을 작성/수정할수있습니다.</p>
                    <%
					}
					else if(boardName.equals("fre")){
					%>
					<h1 class="h3 mb-2 text-gray-800">자유게시판</h1>
                    <p class="mb-4">자유게시판을 작성/수정할수있습니다.</p>
					<%  
					}
					else if(boardName.equals("cal")){
					%>
					<h1 class="h3 mb-2 text-gray-800">프로그램일정</h1>
                    <p class="mb-4">프로그램일정을 작성/수정할수있습니다.</p>
					<%   
					}
					else if(boardName.equals("gal")){
					%>
					<h1 class="h3 mb-2 text-gray-800">사진게시판</h1>
                    <p class="mb-4">사진게시판을 작성/수정할수있습니다.</p>
					<% 
					}
					else if(boardName.equals("ref")){
					%>
					<h1 class="h3 mb-2 text-gray-800">정보자료실</h1>
                    <p class="mb-4">정보자료실을 작성/수정할수있습니다.</p>
					<%  
					}
					
					%>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">등록인원현황</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">

                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                       	<tr> <!-- 꾸밀거면 여기서 꾸미자 -->
											<th>번호</th>
											<th>제목</th>
											<th>작성자</th>
											<th>작성일</th>
											<th>조회수</th>
											<%  	
											if(boardName==null || boardName.equals("info") || boardName.equals("emp") || boardName.equals("guard")){
											%>
											<th class="text-center">첨부</th>
											<%
											}
									        %>
										</tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>번호</th>
                                            <th>제목</th>
                                            <th>작성자</th>
                                            <th>작성일</th>
                                            <th>조회수</th>
                                            <%  	
											if(boardName==null || boardName.equals("info") || boardName.equals("emp") || boardName.equals("guard")){
											%>
											<th class="text-center">첨부</th>
											<%
											}
									        %>
                                        </tr>
                                    </tfoot>                   			
	                                    <tbody>
	                                    <%
										if (boardLists.isEmpty()) {
										// 게시물이 하나도 없을 때 
										%>
														
											<tr>
												<td colspan="5" align="center">
												    등록된 게시물이 없습니다^^*
												</td>
											</tr>
												        
										<%
										}
										else {
											// 게시물이 있을 때 
											int virtualNum = 0;//게시물의 출력 번호
											int countNum = 0;
											for(ProjectBoardDTO dto:boardLists) //반복
											{
											//전체 레코드 수를 1씩 차감하면서 번호를 출력
												//virtualNum = totalCount--;  //전체 게시물 수에서 시작해 1씩 감소
												virtualNum = totalCount - (((pageNum -1) * pageSize) + countNum++);
										%> 
									        <tr>
									        <td><%= virtualNum %></td>
									       
									        
									        <td class="text-left">
									        <a href="board_view03.jsp?idx=<%=dto.getIdx()%>&boardName=<%=boardName%>"><%= dto.getTitle() %>
									        </a></td>
									        
									        
									        <td><%= dto.getId() %></td>
									        <td><%= dto.getPostdate() %></td>
									        <td><%= dto.getVisitcount() %></td>
									        <%  	
											if(boardName==null || boardName.equals("info") || boardName.equals("emp") || boardName.equals("guard")){
											%>
											<td>
												<%if(!(dto.getOfile()==(null))){ %>
												<a href="../space/Download.jsp?oName=<%= URLEncoder.encode(dto.getOfile(),"UTF-8") %>&sName=<%= URLEncoder.encode(dto.getSfile(),"UTF-8") %>">
													<i class="bi-pin-angle-fill" style="font-size: 1rem;"></i></a>
												<%} %>
											</td>
									        <%
											}
									        %>
									        </tr>
									    <%
												
											}
										}
										%>  
	                                   	</tbody>
                                </table> 
                            </div>
                            <div class="row text-right" style="padding-right:50px;">
							<!-- 각종 버튼 부분 -->
							<!-- <button type="reset" class="btn">Reset</button> -->
							<div class="container mt-3">	
							<button type="button" class="btn btn-outline-dark"  
								onclick="location.href='board_write03.jsp?boardName=<%=boardName%>';">글쓰기</button>
									
							<!-- <button type="button" class="btn btn-primary">수정하기</button>
							<button type="button" class="btn btn-success">삭제하기</button>
							<button type="button" class="btn btn-info">답글쓰기</button>
							<button type="button" class="btn btn-warning">리스트보기</button>
							<button type="submit" class="btn btn-danger">전송하기</button> -->
							</div>
                        </div>
                        <div class="row text-center">
					<div class="row mt-3">
                <div class="col">
                    <ul class="pagination justify-content-center">
                        <%=BoardPage.pagingStr(totalCount,pageSize,
        				blockPage, pageNum, request.getRequestURI()) %>
                    </ul>
                </div>
            </div>
</div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.jsp">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

</body>

</html>