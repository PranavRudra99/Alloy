one sig LIM {
	users: some Users
}

some abstract sig Users {}

some sig Doctor extends Users {}
some sig Patient extends Users {
	tests: Patient -> set Test
}
some sig LabExpert extends Users {}

one sig SystemAdministrator extends Users {
	data: SystemAdministrator -> (Users - SystemAdministrator)
}

some sig Test{
	doctor: one Doctor,
	labExpert: one LabExpert
}

fact user {
	users = LIM -> Doctor + 
			LIM -> Patient +
			LIM -> LabExpert +
			LIM -> SystemAdministrator
}

pred show(){
	one s: SystemAdministrator | all u: (Users - SystemAdministrator) | u in s.(s.data)
	all p: Patient | some t: Test | t in p.(p.tests)
	all p1: Patient |all p2:(Patient - p1) | no p1.(p1.tests) & p2.(p2.tests)
}

run show for exactly 10 Users, 5 Test
