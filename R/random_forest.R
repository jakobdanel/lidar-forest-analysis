#' Random Forest Classifier with Leave-One-Out Cross-Validation
#'
#' This function performs a random forest classification using leave-one-out cross-validation for each area in the input tree data.
#' It returns a list containing various results, including predicted species, confusion matrix, accuracy, and the formula used for modeling.
#'
#' @param tree_data A data frame containing the tree data, including the response variable ("specie") and predictor variables.
#' @param excluded_input_columns A character vector specifying columns to be excluded from predictor variables.
#' @param response_variable The response variable to be predicted (default is "specie").
#' @param seed An integer to set the seed for reproducibility (default is 123).
#' @param ... Additional parameters to be passed to the randomForest function.
#' @return A list containing the following elements:
#'   \itemize{
#'     \item \code{predicted_species_absolute}: A data frame with observed and predicted species for each area.
#'     \item \code{predicted_species_relative}: A data frame wit the relative precictions per speices and areas, normalized by the total predictions in each area.
#'     \item \code{confusion_matrix}: A confusion matrix showing the counts of predicted vs. observed species.
#'     \item \code{accuracy}: The accuracy of the model, calculated as the sum of diagonal elements in the confusion matrix divided by the total count.
#'     \item \code{formula}: The formula used for modeling.
#'   }
#'
#' @examples
#' # Assuming tree_data is defined
#' results <- lfa_random_forest(tree_data, excluded_input_columns = c("column1", "column2"))
#'
#' # Print the list of results
#' print(results)
#'
#'@export
lfa_random_forest <-
  function(tree_data,
           excluded_input_columns,
           response_variable = "specie",
           seed = 123,
           ...) {
    set.seed(seed)
    # Determine the predictor variables by excluding specified columns
    predictor_variables <-
      setdiff(names(tree_data),
              c(response_variable, excluded_input_columns))
    tree_data$specie <- as.factor(tree_data$specie)
    # Get unique categories from the 'are' column
    areas <- unique(tree_data$area)
    results_list <- list()
    # Perform leave-one-out cross-validation for each area
    for (area in areas) {
      print(area)
      train_data <- tree_data[tree_data$area != area, ]
      test_data <- tree_data[tree_data$area == area, ]
      formula_str <-
        paste(response_variable,
              "~",
              paste(predictor_variables, collapse = "+"))
      model <-
        randomForest::randomForest(formula(formula_str),
                                   data = train_data,
                                   ntree = 100,
                                   ...)
      predictions <- predict(model, newdata = test_data)
      predictions |> table() |> print()
      result_table <- table(predictions)
      results_list[[area]] <- result_table
      predicted_df <-
        rbind(
          predicted_df,
          data.frame(
            observed = test_data$specie,
            predicted = predictions,
            stringsAsFactors = FALSE
          )
        )
    }
    areas_species <- lfa::lfa_get_all_areas()
    results_df <-
      do.call(rbind, lapply(seq_along(results_list), function(i) {
        data.frame(
          area = names(results_list)[i],
          species = rownames(results_list[[i]]),
          count = as.vector(results_list[[i]])
        )
      }))
    transformed_df <-
      tidyr::spread(results_df, key = species, value = count)
    transformed_df$expected_specie = "Default"
    for (i in 1:nrow(transformed_df)) {
      area <- transformed_df$area[i]
      species <- areas_species[areas_species$area == area, 1]
      transformed_df$expected_specie[i] <- species
    }

    return_list = list()
    confusion_matrix = table(predicted_df$predicted, predicted_df$observed)
    return_list$predicted_species_total = transformed_df

    transformed_df$n = -1
    for (i in 1:nrow(transformed_df)) {
      total <- transformed_df[i,"oak"] + transformed_df[i,"spruce"] + transformed_df[i,"beech"] + transformed_df[i,"pine"]
      transformed_df[i,"n"] = total
      transformed_df[i,"oak"] = transformed_df[i,"oak"] / total
      transformed_df[i,"spruce"] = transformed_df[i,"spruce"] / total
      transformed_df[i,"pine"] = transformed_df[i,"pine"] / total
      transformed_df[i,"beech"] = transformed_df[i,"beech"] / total
    }
    return_list$predicted_species_relative = transformed_df
    return_list$confusion_matrix = confusion_matrix
    return_list$accuracy = sum(diag(confusion_matrix)) / sum(confusion_matrix)
    return_list$formula = formula_str
    return(return_list)
  }
