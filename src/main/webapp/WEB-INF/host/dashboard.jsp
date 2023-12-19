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
      <div class="d-flex justify-content-between">
        <h1>Current Listings</h1>
        <div>
          <a href="/" class="fs-3 me-3">Home</a>
          <a href="/logout" class="fs-3">Logout</a>
        </div>
      </div>
      <div class="row mt-5">
        <div class="col-12">
          <table class="table table-striped border border-1">
            <thead>
              <tr class="table-secondary">
                <th scope="col">Address</th>
                <th scope="col">Pool Size</th>
                <th scope="col">Cost per night</th>
                <th scope="col">Details</th>
                <th scope="col">Delete</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${allPlaces}" var="a">
                <tr>
                  <td>${a.address}</td>
                  <td>${a.poolSize}</td>
                  <td>${a.cost}</td>
                  <td><a href="/host/pools/${a.id}">${a.rating} - edit</a></td>
                  <td>
                    <form action="/host/pools/${a.id}/delete" method="post">
                        <input class="btn btn-danger" type="submit" value="Delete">
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
      <div class="row">
        <div class="col-8 d-flex justify-content-center">
          <form:form
            action="/host/dashboard"
            method="post"
            modelAttribute="place"
            class="mt-5 w-100"
          >
            <form:hidden value="${user.id}" path="userPlace" />
            <fieldset class="border border-3 p-3">
              <legend class="float-none w-auto px-1">New Listing</legend>
              <div class="d-flex justify-content-between mt-3">
                <form:label path="address" class="fs-5 col-4"
                  >Address</form:label
                >
                <form:input
                  path="address"
                  class="col-8 form-control w-50"
                  placeholder="7777 Olive, Seattle, WA 98102"
                />
              </div>
              <form:errors path="address" class="text-danger" />
              <div class="d-flex justify-content-between mt-3">
                <form:label path="description" class="fs-5"
                  >Description</form:label
                >
                <form:textarea
                  path="description"
                  class="col-8 form-control w-50"
                  style="height: 100px"
                />
              </div>
              <form:errors path="description" class="text-danger" />
              <div
                class="d-flex justify-content-between mt-3 align-items-center"
              >
                <form:label path="cost" class="fs-5 col-4"
                  >Cost per night</form:label
                >
                <span class="fs-5">$</span>
                <form:input
                  path="cost"
                  type="number"
                  class="col-8 form-control w-50"
                />
              </div>
              <form:errors path="cost" class="text-danger" />
              <div class="d-flex justify-content-between mt-3">
                <form:label path="poolSize" class="fs-5 col-4"
                  >Pool Size</form:label
                >
                <form:select class="form-select w-50" path="poolSize">
                  <option value="Small" selected>Small</option>
                  <option value="Medium">Medium</option>
                  <option value="Large">Large</option>
                </form:select>
              </div>
              <div class="d-flex justify-content-end mt-3">
                <input
                  type="submit"
                  value="Add Listing"
                  class="btn btn-success"
                />
              </div>
            </fieldset>
          </form:form>
        </div>
      </div>
    </div>
  </body>
</html>
