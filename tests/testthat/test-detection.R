test_that("If their is no tile provided and the path is wrong throw an error", {
  expect_error(detection(NULL,wrong_example_location))
})

dtct <- detection(NULL,true_example_location)
test_that("The function returns an sf object if a correct file path is provided", {
  expect_equal(class(dtct),c("sf","data.frame"))
})

test_that("The detection holds only Point data", {
  for(point in dtct){
    expect_equal(class(point$geometry),c("sfc_POINT","sfc"))
  }
})
