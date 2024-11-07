exports.up = async function (knex, Promise) {
  await knex.schema.table("threads", (table) => {
    table.string("display_name").nullable().defaultTo(null);
  });
};

exports.down = async function (knex, Promise) {
  await knex.schema.table("threads", (table) => {
    table.dropColumn("display_name");
  });
};
