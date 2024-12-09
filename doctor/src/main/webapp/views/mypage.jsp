<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>My Page</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="<c:url value='/img/favicon.ico'/>" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="<c:url value='/css/style.css'/>" rel="stylesheet">
</head>
<body>
<div class="container-fluid pt-4 px-4">
    <div class="row g-4">
        <div class="col-12">
            <div class="bg-light rounded h-100 p-4">
                <h6 class="mb-4">My Page</h6>

                <!-- Status Message -->
                <c:if test="${not empty param.success}">
                    <div class="alert alert-success" role="alert">
                        Profile updated successfully!
                    </div>
                </c:if>
                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger" role="alert">
                        Failed to update profile. Please try again.
                    </div>
                </c:if>

                <!-- Profile Picture -->
                <div class="text-center mb-4">
                    <img src="<c:url value='/img/${doctor.doctorImg != null ? doctor.doctorImg : "default-profile.png"}'/>?${System.currentTimeMillis()}"
                         alt="Profile Picture" class="rounded-circle" style="width: 150px; height: 150px; object-fit: cover;" id="profile-picture">


                </div>
                <!-- Form for Updating Profile -->
                <form action="<c:url value='/mypage/update'/>" method="post" enctype="multipart/form-data" id="update-profile-form">
                    <div class="mb-3">
                        <label for="doctorId" class="form-label">Doctor ID</label>
                        <input type="text" class="form-control" id="doctorId" name="doctorId"
                               value="${doctor.doctorId}" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="doctorName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="doctorName" name="doctorName"
                               value="${doctor.doctorName}" required>
                    </div>
                    <div class="mb-3">
                        <label for="doctorEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="doctorEmail" name="doctorEmail"
                               value="${doctor.doctorEmail}" required>
                    </div>
                    <div class="mb-3">
                        <label for="doctorNumber" class="form-label">Phone Number</label>
                        <input type="tel" class="form-control" id="doctorNumber" name="doctorNumber"
                               value="${doctor.doctorNumber}" required pattern="[0-9]{10,11}"
                               title="Enter a valid phone number with 10-11 digits.">
                    </div>
                    <div class="mb-3">
                        <label for="doctorAge" class="form-label">Age</label>
                        <input type="number" class="form-control" id="doctorAge" name="doctorAge"
                               value="${doctor.doctorAge}" required>
                    </div>
                    <div class="mb-3">
                        <label for="subjectName" class="form-label">Specialty</label>
                        <input type="text" class="form-control" id="subjectName" name="subjectName"
                               value="${doctor.subjectName}" required>
                    </div>
                    <div class="mb-3">
                        <label for="doctorImg" class="form-label">Update Profile Picture</label>
                        <input type="file" class="form-control" id="doctorImg" name="doctorImg" accept="image/*">
                        <small class="form-text text-muted">Allowed formats: JPG, PNG, GIF. Max size: 2MB.</small>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">저장</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).ready(function() {
        // 실시간으로 프로필 이미지를 미리 보기
        $('#doctorImg').change(function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    $('#profile-picture').attr('src', e.target.result);
                }
                reader.readAsDataURL(file);
            }
        });

        // 폼 제출 후 성공 시 페이지 리프레시 없이 이미지를 업데이트
        $('#update-profile-form').on('submit', function(event) {
            event.preventDefault();

            const formData = new FormData(this);
            $.ajax({
                url: $(this).attr('action'),
                type: $(this).attr('method'),
                data: formData,
                contentType: false,
                processData: false,
                success: function(response) {
                    if (response.success) {
                        // 고유한 쿼리 파라미터를 추가하여 캐시 방지
                        const newImgSrc = '/img/' + response.updatedImg + '?' + new Date().getTime();
                        $('#profile-picture').attr('src', newImgSrc);
                        alert('Profile updated successfully!');
                    } else {
                        alert('Failed to update profile. Please try again.');
                    }
                },
                error: function() {
                    alert('An error occurred while updating the profile.');
                }
            });
        });
    });
</script>
</body>
</html>