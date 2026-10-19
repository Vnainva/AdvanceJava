    public StudentRegistration() {
        setTitle("Student Registration Form");
        setSize(450, 450);
        setLayout(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Student Name
        lblName = new JLabel("Student Name");
        lblName.setBounds(30, 30, 120, 30);
        add(lblName);

        txtName = new JTextField();
        txtName.setBounds(170, 30, 180, 30);
        add(txtName);

        // Roll Number
        lblRoll = new JLabel("Roll Number");
        lblRoll.setBounds(30, 80, 120, 30);
        add(lblRoll);

        txtRoll = new JTextField();
        txtRoll.setBounds(170, 80, 180, 30);
        add(txtRoll);

        // Gender
        lblGender = new JLabel("Gender");
        lblGender.setBounds(30, 130, 120, 30);
        add(lblGender);

        male = new JRadioButton("Male");
        male.setBounds(170, 130, 80, 30);
        add(male);

        female = new JRadioButton("Female");
        female.setBounds(260, 130, 100, 30);
        add(female);

        genderGroup = new ButtonGroup();
        genderGroup.add(male);
        genderGroup.add(female);

        // Branch
        lblBranch = new JLabel("Branch");
        lblBranch.setBounds(30, 180, 120, 30);
        add(lblBranch);

        txtBranch = new JTextField();
        txtBranch.setBounds(170, 180, 180, 30);
        add(txtBranch);

        // Terms & Conditions
        terms = new JCheckBox("I accept Terms & Conditions");
        terms.setBounds(30, 230, 250, 30);
        add(terms);

        // Submit Button
        submit = new JButton("Submit");
        submit.setBounds(80, 290, 100, 35);
        submit.addActionListener(this);
        add(submit);

        // Reset Button
        reset = new JButton("Res