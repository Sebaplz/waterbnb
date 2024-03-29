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
            <c:choose>
              <c:when test="${userRol.equals('host')}">
                <a href="/host/dashboard" class="fs-3 me-3">Dashboard</a>
                <a href="/logout" class="fs-3">Logout</a>
              </c:when>
              <c:otherwise>
                <a href="/logout" class="fs-3">Logout</a>
              </c:otherwise>
            </c:choose>
          </c:when>
          <c:otherwise>
            <a href="/guest/signin" class="fs-3">Signing/Sigup</a>
          </c:otherwise>
        </c:choose>
      </div>
      <h2 class="text-center mt-5">
        Find places to swim and sleep on water bnb!
      </h2>
      <form action="/search" method="get">
        <div class="d-flex justify-content-center mt-5">
          <input type="text" class="form-control w-25 me-2" placeholder="location" name="q" />
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
                <c:forEach items="${placePage.content}" var="p">
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
        <!-- Paginación -->
        <div class="d-flex justify-content-center mt-5">
            <ul class="pagination">
                <c:forEach begin="0" end="${placePage.totalPages - 1}" var="i">
                    <li class="page-item <c:if test="${placePage.number eq i}">active</c:if>">
                        <a class="page-link" href="/?page=${i}&size=${placePage.size}">${i + 1}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
  </body>
</html>
