DROP TABLE IF EXISTS project_category;
DROP TABLE IF EXISTS material;
DROP TABLE IF EXISTS step;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS project;

CREATE TABLE project (
	project_id INT NOT NULL AUTO_INCREMENT, /*PK*/
	project_name VARCHAR(128) NOT NULL,
	estimated_hours DECIMAL(7,2),
	actual_hours DECIMAL(7,2),
	difficulty INT,
	notes TEXT,
	PRIMARY KEY (project_id)
);

CREATE TABLE material (
	material_id INT NOT NULL AUTO_INCREMENT, /*PK*/
	project_id INT NOT NULL, /*FK*/
	material_name VARCHAR(128) NOT NULL,
	num_required INT,
	cost DECIMAL(7,2),
	PRIMARY KEY (material_id),
	FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE
);

CREATE TABLE step (
	step_id INT NOT NULL AUTO_INCREMENT,  /*PK*/
	project_id INT NOT NULL, /*FK*/
	step_text TEXT NOT NULL,
	step_order INT NOT NULL,
	PRIMARY KEY (step_id),
	FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE
);

CREATE TABLE category (
	category_id INT NOT NULL AUTO_INCREMENT, /*PK*/
	category_name VARCHAR(128),
	PRIMARY KEY (category_id)
);

CREATE TABLE project_category (
	project_id INT NOT NULL, /*FK, UK with category_id*/
	category_id INT NOT NULL, /*FK, UK with project_id*/
	FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE,
	FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE,
	UNIQUE (project_id, category_id)
);

INSERT INTO project (project_name, estimated_hours, actual_hours, difficulty, notes) VALUES ('Hang a door', 1, 1, 2, 'It will not hang itself');
INSERT INTO material (project_id, material_name, num_required, cost) VALUES (1, '2-inch screws', 20, 1.09);
INSERT INTO material (project_id, material_name, num_required, cost) VALUES (1, 'Door hinges', 3, 2.00);
INSERT INTO step (project_id, step_text, step_order) VALUES (1, 'Align door hinges near the top, middle, and bottom on the side of each door frame', 1);
INSERT INTO step (project_id, step_text, step_order) VALUES (1, 'Screw the hinges into the door frame', 1);
INSERT INTO category (category_name) VALUES ('Doors and Windows');
INSERT INTO category (category_name) VALUES ('Repairs');
INSERT INTO category (category_name) VALUES ('DIY');
INSERT INTO project_category (project_id, category_id) VALUES (1, 1);
INSERT INTO project_category (project_id, category_id) VALUES (1, 2);
INSERT INTO project_category (project_id, category_id) VALUES (1, 3);