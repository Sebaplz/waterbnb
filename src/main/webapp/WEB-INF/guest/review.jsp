<!-- c:out ; c:forEach etc. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Formatting (dates) -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>WaterBnB</title>
    <!-- for Bootstrap CSS -->
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/style.css" />
    <!-- For any Bootstrap that uses JS -->
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
  </head>
  <body>
    <div class="container mt-5">
      <div class="d-flex justify-content-between">
        <h1>Review of ${place.address}</h1>
        <div>
          <a href="/" class="fs-3 me-3">Home</a>
          <a href="/logout" class="fs-3">Logout</a>
        </div>
      </div>
      <div class="row">
        <div class="col-8 d-flex justify-content-center">
          <form:form
            action="/pools/${place.id}/review"
            method="post"
            modelAttribute="review"
            class="w-100 mt-3"
          >
            <form:hidden value="${user.id}" path="author" />
            <form:hidden value="${place.id}" path="place" />
            <div class="d-flex justify-content-between mt-3">
              <form:textarea
                path="comment"
                class="col-8 form-control w-75"
                style="height: 200px"
              />
            </div>
            <form:errors path="comment" class="text-danger" />
            <div class="d-flex justify-content-between mt-3 w-75">
              <form:label path="rating" class="fs-5">Rating</form:label>
              <form:select class="form-select w-25" path="rating">
                <option value="1.0" selected>1</option>
                <option value="2.0">2</option>
                <option value="3.0">3</option>
                <option value="4.0">4</option>
                <option value="5.0">5</option>
              </form:select>
              <input
                type="submit"
                value="Submit Review"
                class="btn btn-success"
              />
            </div>
          </form:form>
        </div>
      </div>
    </div>
  </body>
</html>
