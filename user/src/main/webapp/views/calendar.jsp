<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 날짜 선택</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <style>
        body {
            font-family: Heebo, sans-serif;
        }
        .calendar-container {
            width: 100%;
            max-width: 700px;
            margin: 0 auto;
            border: 2px solid lightgray;
        }
        .calendar-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .calendar-header button {
            padding: 5px 15px;
        }
        .calendar-table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;

        }
        .calendar-table th,
        .calendar-table td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        .event {
            cursor: pointer;
            background-color: lightskyblue;
        }
        .event:hover {
            background-color: #8BC34A;
        }
        .selected {
            background-color: floralwhite;
            color: white;
        }
        .disabled {
            color: #d3d3d3;
        }

        .event.selected {
            background-color: floralwhite;
            color: white;
        }
    </style>
</head>
<body>


<div class="calendar-container">
    <div class="calendar-header">
        <button id="prevMonth">이전달</button>
        <span id="currentMonthYear">2024년 11월</span>
        <button id="nextMonth">다음달</button>
    </div>
    <table class="calendar-table" id="calendarTable">
        <thead>
        <tr>
            <th>일</th>
            <th>월</th>
            <th>화</th>
            <th>수</th>
            <th>목</th>
            <th>금</th>
            <th>토</th>
        </tr>
        </thead>
        <tbody id="calendarBody"></tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script>
    let currentYear = 2024;
    let currentMonth = 10; // 11월을 기준으로 시작 (0부터 시작이므로 10은 11월)
    let selectedDate = null;

    // 서버로 날짜 전송
    function sendDateToServer(date) {
        sessionStorage.setItem('selectedDate', date);
        console.log(date)

        const dateInput = document.getElementById("date");
        if (dateInput) {
            dateInput.value = date;
            console.log("Date saved and input updated: " + date);
        } else {
            console.error("Hidden input field not found.");
        }

        // 선택한 날짜를 동적으로 표시 (예: 선택된 UI 강조)
        // const dateElements = document.querySelectorAll('li a'); // 날짜 요소들 선택
        // dateElements.forEach(item => item.classList.remove('selected')); // 모든 선택 해제
        //
        // const selectedElement = [...dateElements].find(el => el.textContent.trim() === date);
        // if (selectedElement) {
        //     selectedElement.classList.add('selected'); // 선택된 날짜 강조
        // }


    }


    // 달력 그리기
    function renderCalendar(year, month) {
        const firstDay = new Date(year, month, 1).getDay();
        const lastDate = new Date(year, month + 1, 0).getDate();
        const prevLastDate = new Date(year, month, 0).getDate();

        const calendarBody = document.getElementById('calendarBody');
        const currentMonthYear = document.getElementById('currentMonthYear');

        currentMonthYear.textContent = year + "년 " + (month + 1) + "월";
        calendarBody.innerHTML = '';

        let date = 1;
        let html = '';
        html += '<tr>';

        // 첫 번째 주의 빈 셀 처리 (이전 달의 날짜들)
        for (let i = 0; i < 7; i++) {
            if (i < firstDay) {
                html += '<td class="disabled">' + (prevLastDate - firstDay + i + 1) + '</td>';
            } else {
                html += '<td class="event" data-date="' + year + '-' + (month + 1) + '-' + date + '" data-handler="selectDay">' + date + '</td>';
                date++;
            }
        }
        html += '</tr>';

// 두 번째 주부터 마지막 주까지 날짜 그리기
        while (date <= lastDate) {
            html += '<tr>';
            for (let i = 0; i < 7; i++) {
                if (date > lastDate) {
                    html += '<td class="disabled"></td>';
                } else {
                    html += '<td class="event" data-date="' + year + '-' + (month + 1) + '-' + date + '" data-handler="selectDay">' + date + '</td>';
                    date++;
                }
            }
            html += '</tr>';
        }

        calendarBody.innerHTML = html;

// 날짜 클릭 이벤트
        document.querySelectorAll('.event').forEach(cell => {
            cell.addEventListener('click', () => {
                selectDate(cell.getAttribute('data-date'));
            });
        });
    }

    // 날짜 선택 시 처리
    function selectDate(date) {
        if (selectedDate) {
            document.querySelector('[data-date="' + selectedDate + '"]').classList.remove('selected');
        }
        selectedDate = date;
        document.querySelector('[data-date="' + selectedDate + '"]').classList.add('selected');
        sendDateToServer(selectedDate);

    }




    // 이전 달 이동
    document.getElementById('prevMonth').addEventListener('click', () => {
        currentMonth--;
        if (currentMonth < 0) {
            currentYear--;
            currentMonth = 11;
        }
        renderCalendar(currentYear, currentMonth);
    });

    // 다음 달 이동
    document.getElementById('nextMonth').addEventListener('click', () => {
        currentMonth++;
        if (currentMonth > 11) {
            currentYear++;
            currentMonth = 0;
        }
        renderCalendar(currentYear, currentMonth);
    });

    // 초기 달력 렌더링
    renderCalendar(currentYear, currentMonth);
</script>

</body>
</html>