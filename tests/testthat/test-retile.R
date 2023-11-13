
test_that("retiling do not work for dirs that are not existent", {
  expect_error(retile(wrong_example_location))
})

test_that("retiling produces an warning if the tile already exists", {
  expect_warning(retile(true_example_location))
})

