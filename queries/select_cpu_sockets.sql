select b.short_name, st.acronym, pcc.name, pcc.release_date_year  from pc_component pcc
join brand b on b.brand_id = pcc.brand_id
join cpu_socket cpus on cpus.pc_component_id = pcc.pc_component_id
join socket_type st on st.socket_type_id = cpus.socket_type_id