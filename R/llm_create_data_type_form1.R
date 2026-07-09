#'
#' Create form 1 output type specification
#' 

llm_create_form1_type <- function() {
  ellmer::type_array(
    ellmer::type_object(
      "Specification of expected data structure for form 1 synthetic data",
      type_of_vaccine = ellmer::type_enum(
        values = c(
          "BCG", "Hepatitis B", "Polio",
          "Diphtheria, Tetanus, and Pertussis (Whooping Cough)",
          "Haemophilus influenzae type b (Hib)", "Measles and Rubella",
          "Japanese Encephalitis", "Rotavirus", "Pneumococcal Disease (PCV)",
          "Human Papillomavirus (HPV)", "Influenza", "Varicella (Chickenpox)",
          "Hepatitis A", "Typhoid & Cholera", "Meningococcal Disease", "COVID-19"
        ),
        description = "Type of vaccine administered to the patient.",
        required = TRUE
      ),
      vaccine_trade_name = ellmer::type_enum(
        values = c(
          "Bacille Calmette-Guérin", "Engerix-B", "Recombivax HB", "Comvax",
          "IPV", "OPV", "DTaP", "Tdap", "Hiberix", "ActHIB", "MMR", "Priorix-Tetra",
          "Ixiaro", "RotaTeq", "Rotarix", "Prevnar 13", "Pneumovax 23", "Gardasil",
          "Cervarix", "Fluzone", "FluMist", "Zostavax", "Varivax", "Havrix",
          "Vaqta", "Typhim Vi", "Vivotif", "Menactra", "Menomune-A/C/Y/W-135",
          "Nimenrix", "Comirnaty", "Spikevax", "Jcovden"
        ),
        description = "Trade name of the vaccine administered to the patient.",
        required = TRUE
      ),
      authorisation_number = ellmer::type_string(
        description = "Authorisation number for the vaccine administered to the patient with the format [A-Z]{3}-[0-9]{6}.",
        required = TRUE
      ),
      lot_number = ellmer::type_string(
        description = "Lot number for the vaccine administered to the patient with the format [0-9]{3}-[0-9]{2}-[0-9]{2}.",
        required = TRUE
      ),
      expiry_date = ellmer::type_string(
        description = "Expiry date for the vaccine administered to the patient in YYYY-MM-DD format.",
        required = TRUE
      ),
      customer_id = ellmer::type_string(
        description = "Customer ID for the patient with the format [0-9]{10}.",
        required = TRUE
      ),
      fever = ellmer::type_enum(
        values = c("yes", "no"),
        description = "Did the patient experience fever > 39 degrees Celsius?",
        required = TRUE
      ),
      swelling_pain = ellmer::type_enum(
        values = c("yes", "no"),
        description = "Did the patient experience pain or swelling at the injection site?",
        required = TRUE
      ),
      other_symptoms = ellmer::type_string(
        description = "Other symptoms experienced by the patient.",
        required = TRUE
      ),
      managed_at_home = ellmer::type_enum(
        values = c("yes", "no"),
        description = "Was the patient managed at home?",
        required = TRUE
      ),
      notes = ellmer::type_string(
        description = "Any additional notes about the patient's condition or treatment.",
        required = FALSE
      )
    )
  )
}