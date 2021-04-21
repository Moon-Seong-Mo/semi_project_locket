<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/resources/globalVariable.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬 마켓</title>

<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/group_schedule.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/js/calender.js">

</head>
<body>
	<div class="wrap">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp"%>
			
			
			
			<div id="content">
				<input type="text" placeholder="검색어를 입력하세요"
					style="width: 300px; height: 40px; margin-top: 100px; margin-left: 200px;">
				<button style="width: 60px; height: 40px;">검색</button>
				<br>
				<br>
				<br>
				<h1>공동구매 캘린더</h1>
				<br>
				<hr>
				<br><br><br>
				
				
				
				
				<div id="calender-title">캘린더</div>

				<div id="cal-area">
					<input type="button" id="before_month" value="이전달"> 
					<input type="button" id="after_month" value="다음달">
				</div>

				<div id="calendar"></div>
				
				<script>
					var today = new Date();
					var year = today.getFullYear();
					var month = today.getMonth();

					window.onload = function() {
						calendarSet(today);
					};

					var beforeMonth = document.getElementById('before_month');
					var afterMonth = document.getElementById('after_month');

					beforeMonth.onclick = function() {
						if(month == 0) {
							year--;
							month = 11;
						} else {
							month--;
						}
						today.setFullYear(year, month);
						calendarSet(today);
					};

					afterMonth.onclick = function() {
						if(month == 11) {
							year++;
							month = 0;
						} else {
							month++;
						}
						today.setFullYear(year, month);
						calendarSet(today);
					};



					var calendarSet = function(today) {
						var year = today.getFullYear();
						var month = today.getMonth();
						
						
						document.getElementById('calender-title').innerHTML = year + "년 " + (month + 1) + "월";

						const setCalendarData = (year, month) => {
							let calHtml = "";

							//getMonth(): Get the month as a number (0-11)
							//month 인자는 getMonth로 구한 결과 값에 1을 더한 상태
							const setDate = new Date(year, month - 1, 1);

							//getDate(): Get the day as a number (1-31)
							//이번 달의 첫째 날을 구합니다.
							const firstDay = setDate.getDate();

							//getDay(): Get the weekday as a number (0-6)
							//이번 달의 처음 요일을 구합니다.
							const firstDayName = setDate.getDay();

							//new Date(today.getFullYear(), today.getMonth(), 0);
							//Date객체의 day 인자에 0을 넘기면 지난달의 마지막 날이 반환됩니다.
							//new Date(today.getFullYear(), today.getMonth(), 1);
							//Date객체의 day 인자에 1을 넘기면 이번달 첫째 날이 반환됩니다.
							//이번 달의 마지막 날을 구합니다.
							const lastDay = new Date(
								today.getFullYear(),
								today.getMonth() + 1,
								0
							).getDate();
							//지난 달의 마지막 날을 구합니다.
							const prevLastDay = new Date(
								today.getFullYear(),
								today.getMonth(),
								0
							).getDate();

							//매월 일수가 달라지므로 이번 달 날짜 개수를 세기 위한 변수를 만들고 초기화 합니다.
							let startDayCount = 1;
							let lastDayCount = 1;

							var dow = ['일', '월', '화', '수', '목', '금', '토'];

							for (var i = 0; i < 7; i++) {
								calHtml +=
									`<div class='calendar__day horizontalGutter dayofweek'><span>${dow[i]}</span><span></span></div>`;
							}

							//1~5주차를 위해 5번 반복합니다.
							for (let i = 0; i < 5; i++) {
								//일요일~토요일을 위해 7번 반복합니다.
								for (let j = 0; j < 7; j++) {
									// i == 0: 1주차일 때
									// j < firstDayName: 이번 달 시작 요일 이전 일 때
									if (i == 0 && j < firstDayName) {
										//일요일일 때, 토요일일 때, 나머지 요일 일 때
										if (j == 0) {
											calHtml +=
												`<div style='background-color:#FFB3BB;' class='calendar__day horizontalGutter'><span>${(prevLastDay - (firstDayName - 1) + j)}</span><span></span></div>`;
										} else if (j == 5) {
											calHtml +=
												`<div style='background-color:#FFB3BB;' class='calendar__day'><span>${(prevLastDay - (firstDayName - 1) + j)}</span><span></span></div>`;
										} else {
											calHtml +=
												`<div style='background-color:#FFB3BB;' class='calendar__day horizontalGutter'><span>${(prevLastDay - (firstDayName - 1) + j)}</span><span></span></div>`;
										}
									}
									// i == 0: 1주차일 때
									// j == firstDayName: 이번 달 시작 요일일 때
									else if (i == 0 && j == firstDayName) {
										//일요일일 때, 토요일일 때, 나머지 요일 일 때
										if (j == 0) {
											calHtml +=
												`<div style='background-color:#FFE0BB;' class='calendar__day horizontalGutter'><span>${startDayCount}</span><span id='${year}${month}${setFixDayCount(startDayCount++)}'></span></div>`;
										} else if (j == 5) {
											calHtml +=
												`<div style='background-color:#FFE0BB;' class='calendar__day'><span>${startDayCount}</span><span id='${year}${month}${setFixDayCount(startDayCount++)}'></span></div>`;
										} else {
											calHtml +=
												`<div style='background-color:#FFE0BB;' class='calendar__day horizontalGutter'><span>${startDayCount}</span><span id='${year}${month}${setFixDayCount(startDayCount++)}'></span></div>`;
										}
									}
									// i == 0: 1주차일 때
									// j > firstDayName: 이번 달 시작 요일 이후 일 때
									else if (i == 0 && j > firstDayName) {
										//일요일일 때, 토요일일 때, 나머지 요일 일 때
										if (j == 0) {
											calHtml +=
												`<div style='background-color:#FFFFBB' class='calendar__day horizontalGutter'><span>${startDayCount}</span><span id='${year}${month}${setFixDayCount(startDayCount++)}'></span></div>`;
										} else if (j == 5) {
											calHtml +=
												`<div style='background-color:#FFFFBB' class='calendar__day'><span>${startDayCount}</span><span id='${year}${month}${setFixDayCount(startDayCount++)}'></span></div>`;
										} else {
											calHtml +=
												`<div style='background-color:#FFFFBB' class='calendar__day horizontalGutter'><span>${startDayCount}</span><span id='${year}${month}${setFixDayCount(startDayCount++)}'></span></div>`;
										}
									}
									// startDayCount <= lastDay: 이번 달의 마지막 날이거나 이전일 때
									else if (i > 0 && startDayCount <= lastDay) {
										//일요일일 때, 토요일일 때, 나머지 요일 일 때
										if (j == 0) {
											calHtml +=
												`<div style='background-color:#BBFFC9;'class='calendar__day horizontalGutter verticalGutter'><span>${startDayCount}</span><span id='${year}${month}${setFixDayCount(startDayCount++)}'></span></div>`;
										} else if (j == 6) {
											calHtml +=
												`<div style='background-color:#BBFFC9;'class='calendar__day verticalGutter'><span>${startDayCount}</span><span id='${year}${month}${setFixDayCount(startDayCount++)}'></span></div>`;
										} else {
											calHtml +=
												`<div style='background-color:#BBFFC9;'class='calendar__day horizontalGutter verticalGutter'><span>${startDayCount}</span><span id='${year}${month}${setFixDayCount(startDayCount++)}'></span></div>`;
										}
									}
									// startDayCount > lastDay: 이번 달의 마지막 날 이후일 때
									else if (startDayCount > lastDay) {
										if (j == 0) {
											calHtml +=
												`<div style='background-color:#B9E1FF;' class='calendar__day horizontalGutter verticalGutter'><span>${lastDayCount++}</span><span></span></div>`;
										} else if (j == 6) {
											calHtml +=
												`<div style='background-color:#B9E1FF;' class='calendar__day verticalGutter'><span>${lastDayCount++}</span><span></span></div>`;
										} else {
											calHtml +=
												`<div style='background-color:#B9E1FF;' class='calendar__day horizontalGutter verticalGutter'><span>${lastDayCount++}</span><span></span></div>`;
										}
									}
								}
							}
							//캘린더 div 태그에 내용 붙임
							document.getElementById('calendar').innerHTML = calHtml;
								// .querySelector("#calendar")
								// .insertAdjacentHTML("beforeend", calHtml);
						};

						const setFixDayCount = number => {
							//캘린더 하루마다 아이디를 만들어주기 위해 사용
							let fixNum = "";
							if (number < 10) {
								fixNum = "0" + number;
							} else {
								fixNum = number;
							}
							return fixNum;
						};

						if (today.getMonth() + 1 < 10) {
							setCalendarData(today.getFullYear(), "0" + (today.getMonth() + 1));
						} else {
							setCalendarData(today.getFullYear(), "" + (today.getMonth() + 1));
						}
					}	
					
				</script>
			</div>
		</div>
	</div>

	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
	
	<%@ include file="/WEB-INF/views/common/ad.jsp" %>

</body>
</html>