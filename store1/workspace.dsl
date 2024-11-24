workspace {

    model {
        customer = person "Web Customer" "Online customer of the platform"

        store = softwareSystem "Web store" "Clients can place an order online"
        logistics = softwareSystem "Logistics & Delivery" "Stock management and orders delivery"
        payment = softwareSystem "Payment & Billing" "Payment management and billing"

        // Relationships
        customer -> store "Uses"
        store -> payment "Uses"
        store -> logistics "Uses"
    }

    views {
        // Diagrams
        systemContext store "StoreContext" {
            include *
            autoLayout
        }

        // Theme and style
        theme default
    }

}