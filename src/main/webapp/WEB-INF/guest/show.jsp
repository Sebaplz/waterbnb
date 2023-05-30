<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!-- c:out ; c:forEach etc. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Formatting (dates) -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true"%>
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
      <div class="d-flex justify-content-end">
        <c:choose>
          <c:when test="${userLogeado != null}">
            <a href="/" class="fs-3 me-3">Home</a>
            <a href="/logout" class="fs-3">Logout</a>
          </c:when>
          <c:otherwise>
            <a href="/guest/signin" class="fs-3">Signing/Sigup</a>
          </c:otherwise>
        </c:choose>
      </div>
      <div class="row mt-3 align-items-baseline">
        <div class="col-6">
          <h1>${place.address}</h1>
          <h3>${place.description}</h3>
        </div>
        <div class="col-6">
          <h2>Email: ${place.userPlace.email}</h2>
          <h2>
            Name: ${place.userPlace.firstName} ${place.userPlace.lastName}
          </h2>
          <h2>Pool Size: ${place.poolSize}</h2>
          <h2>Cost: $ ${place.cost}</h2>
        </div>
      </div>
      <div class="row mt-3">
        <div class="col-12 d-flex justify-content-between">
          <h2>Reviews (${place.rating}/5):</h2>
          <div>
            <c:choose>
              <c:when test="${userLogeado != null}">
                <c:choose>
                  <c:when test="${userRol.equals('guest')}">
                    <a href="/pools/${place.id}/review" class="fs-3"
                      >Leave a review</a
                    >
                  </c:when>
                  <c:otherwise>
                    <a href="/" class="fs-3">Leave a review</a>
                  </c:otherwise>
                </c:choose>
              </c:when>
              <c:otherwise>
                <a href="/guest/signin" class="fs-3">Leave a review</a>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
        <div class="col-12">
          <div class="border border-2 p-2" style="height: 480px; overflow-y: scroll;">
            <c:forEach items="${place.reviews}" var="review">
              <h4>${review.author.firstName}:</h4>
              <h4>Rating: ${review.rating}/5</h4>
              <p class="px-2">${review.comment}</p>
              <hr>
            </c:forEach>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
