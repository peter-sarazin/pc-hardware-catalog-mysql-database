# pc-hardware-catalog-mysql-database
Database model representing a catalog of personal computer hardware.

This repo contains the pc-hardware-catalog-database data model design along with any scripts.

[!NOTE]
I am thinking about limiting the scope of this database to thorougly describe the motherboard including supported CPUs, supported memory, and expansion slots. This may also mean breaking out the top level enities of brand, abstract_entity, and pac_component into a shared database (perhaps its own microservice) that can be referenced from other databases/services. I will have to think about this.
