workspace {

    model {
        customer = person "Web Customer" "Online customer of the platform"

        // Components (containers) of the web store
        store = softwareSystem "Web store" "Clients can place an order online" {

            // containers
            webApp = container "Web Application" "Website of the online store" "React" "Frontend"
            orderSrv = container "Order service" "Online order management" "Node.js" "Backend" {
                userController = component "User Controller"
                eventService = component "Event Service"
                emailService = component "Email Service"
            }
            catalogSrv = container "Web catalog service" "Reference of all items of the online store" "Node.js" "Backend" 
            orderDb = container "Order database" "Orders list" "PostgreSQL" "Database"
            catalogDb = container "Catalog database" "Catalog list" "PostgreSQL" "Database"
        }

        logistics = softwareSystem "Logistics & Delivery" "Stock management and orders delivery"
        payment = softwareSystem "Payment & Billing" "Payment management and billing"

        // Relationships towards systems
        customer -> store "Uses"
        store -> payment "Uses"
        store -> logistics "Uses"

        // Relationships towards containers
        customer -> webApp "Browse web store" "HTTPS"
        webApp -> orderSrv "Manage orders through a REST API" "HTTPS"
        webApp -> catalogSrv "Get items through a REST API" "HTTPS"
        orderSrv -> catalogSrv "Get items through a REST API" "HTTPS"
        orderSrv -> logistics "Send delivery request" "RabbitMQ"
        orderSrv -> payment "Send payment request" "HTTPS"
        orderSrv -> orderDb "Read and write in the database" "SQL/TCP"
        orderSrv -> catalogDb "Read in the database" "SQL/TCP"

        // Relationships towards components
        userController -> eventService "Uses"
        eventService -> orderDb "Read and write in the database" "SQL/TCP"  
    }

    views {
        // Diagrams
        systemContext store "StoreContext" {
            include *
            animation {
                customer
                store
                logistics
                payment
            }
            autoLayout
        }

        container store "StoreContainers" {
            include *
            autoLayout
            description "There are containers"
        }

        component orderSrv "StoreComponent" {
            include *
            autoLayout
        }

        // Theme and style
        theme default

        styles {
            element "Database" {
                shape Cylinder
                background #999999
            }

            element "Frontend" {
                shape WebBrowser
                icon "./icons/react-icon.png"
            }

            element "Backend" {
                icon "./icons/nodejs-icon.png"
            }
        }
    }

}