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
      <div class="d-flex justify-content-between">
        <h1>${places.address}</h1>
        <div>
          <a href="/host/dashboard" class="fs-3 me-3">Dashboard</a>
          <a href="/logout" class="fs-3">Logout</a>
        </div>
      </div>
      <form:form
        action="/host/pools/${places.id}"
        method="post"
        modelAttribute="place"
        class="mt-3"
      >
        <div class="row">
          <div class="col-12 d-flex justify-content-center">
            <div class="col-6">
              <input type="hidden" name="_method" value="put">
              <form:hidden value="${user.id}" path="userPlace" />
              <form:hidden value="${places.address}" path="address" />
              <div class="d-flex justify-content-between mt-3">
                <textarea
                    name="description"
                    class="col-8 form-control w-75"
                    style="height: 200px"
                >${places.description}</textarea>
              </div>
              <form:errors path="description" class="text-danger" />
              <div class="d-flex justify-content-start mt-3">
                <input
                  type="submit"
                  value="Save Changes"
                  class="btn btn-success"
                />
              </div>
            </div>
            <div class="col-6">
              <div class="d-flex justify-content-between mt-3">
                <p class="fs-5">Email: ${user.email}</p>
              </div>
              <div class="d-flex justify-content-between">
                <p class="fs-5">Name: ${user.firstName} ${user.lastName}</p>
              </div>
              <div class="d-flex justify-content-between">
                <form:label path="poolSize" class="fs-5 col-4"
                  >Pool Size</form:label
                >
                <form:select class="form-select w-50" path="poolSize">
                  <option value="Small">Small</option>
                  <option value="Medium">Medium</option>
                  <option value="Large">Large</option>
                </form:select>
              </div>
              <div
                class="d-flex justify-content-between mt-2 align-items-center"
              >
                <form:label path="cost" class="fs-5 col-4"
                  >Cost</form:label
                >
                <span class="fs-5">$</span>
                <form:input
                  path="cost"
                  type="number"
                  class="col-8 form-control w-50"
                  value="${places.cost}"
                />
              </div>
            </div>
          </div>
        </div>
      </form:form>
      <div class="row mt-3">
        <h2>Reviews (${places.rating}/5):</h2>
        <div class="col-12">
          <div class="border border-2 p-2" style="height: 480px; overflow-y: scroll;">
            <c:forEach items="${places.reviews}" var="review">
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
