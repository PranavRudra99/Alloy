one sig LIM {
	users: some Users
}

some abstract sig Users {}

some sig Doctor extends Users {}
some sig Patient extends Users {}
some sig LabExpert extends Users {}

one sig SystemAdministrator extends Users {
	data: SystemAdministrator -> (Users - SystemAdministrator)
}

fact user {
	users = LIM -> Doctor + 
			LIM -> Patient +
			LIM -> LabExpert +
			LIM -> SystemAdministrator
}

pred show(){
	one s: SystemAdministrator | all u: (Users - SystemAdministrator) | u in s.(s.data)
}

run show for exactly 10 Users
