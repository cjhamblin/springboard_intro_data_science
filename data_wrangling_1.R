# read refine.xlsx
refine <- read.csv("~/Data Science/Springboard/refine.csv")

# correct company names
refine$company <- lapply(refine$company, tolower)
refine$company <- gsub("phillips|philips|phllips|phillps|fillips|phlips", "philips", refine$company)
refine$company <- gsub("akzo|Akzo|AKZO|akz0|ak zo", "akzo", refine$company)
refine$company <- gsub("unilver|unilever", "unilever", refine$company)


# rename product code column
colnames(refine)[2] <- "product"

# seperate product_code and number
refine <- refine %>% separate(product, c("product_code", "product_number"), sep = "-")

# add column for product category
refine <- mutate(refine, product_category = 
                ifelse(product_code =="p","smartphone",
                ifelse(product_code =="v","tv", 
                ifelse(product_code=="x","laptop", 
                ifelse(product_code=="q","tablet", product_code)))))

# full address
refine <- unite(refine, "full_address", address, city, country, sep = ",", remove = FALSE)

#dummy variables for company 
refine <- mutate(refine, company_philips = ifelse(company =="philips",1,0), 
                company_akzo = ifelse(company =="akzo",1,0), 
                company_van_houten = ifelse(company =="van houten",1,0), 
                company_unilever = ifelse(company =="unilever",1,0))

#dummy variables for products
refine <- mutate(refine, product_smartphone = ifelse(product_category =="smartphone",1,0), 
                product_tv = ifelse(product_category =="tv",1,0), 
                product_laptop = ifelse(product_category =="laptop",1,0), 
                product_tablet = ifelse(product_category =="tablet",1,0))

#export cleaned data set
write.csv(refine, "refine_clean.csv")
