<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
      <h2>Find your pool!</h2>
      <form action="/search" method="get">
        <div class="d-flex justify-content-start mt-5">
          <input
            type="text"
            class="form-control w-25 me-2"
            placeholder="new search"
            name="q"
          />
          <button type="submit" class="btn btn-success" type="button">
            Search
          </button>
        </div>
      </form>
      <div class="row mt-5">
        <div class="col-12">
          <table class="table table-striped border border-1">
            <thead>
              <tr class="table-secondary">
                <th scope="col">Address</th>
                <th scope="col">Pool Size</th>
                <th scope="col">Cost per night</th>
                <th scope="col">Details</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${placeList}" var="p">
                <tr>
                  <td>${p.address}</td>
                  <td>${p.poolSize}</td>
                  <td>${p.cost}</td>
                  <td><a href="/pools/${p.id}">${p.rating}/5 - See more</a></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </body>
</html>
