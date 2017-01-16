/*
 * Copyright (c) 2017 The American National Corpus
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.anc.lapps.datasource.generic;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

import org.lappsgrid.discriminator.Discriminators;
import org.lappsgrid.serialization.Data;
import org.lappsgrid.serialization.Serializer;

/**
 * @author Keith Suderman
 */
public class GenericDatasourceTests
{
	protected DataSource datasource;

	public GenericDatasourceTests()
	{

	}

	@Before
	public void setup()
	{
		System.setProperty(DataSource.PROPERTY_NAME, "/var/corpora/FDR/index.txt");
		datasource = new DataSource();
	}

	@After
	public void teardown()
	{
		datasource = null;
	}

	@Test
	public void indexFromProperty()
	{
		Data data = new Data(Discriminators.Uri.SIZE);
		String json = datasource.execute(data.asJson());
		data = Serializer.parse(json, Data.class);
		assertEquals("Invalid discriminator", Discriminators.Uri.OK, data.getDiscriminator());
		assertEquals("Wrong number of entries", 107, Integer.parseInt(data.getPayload().toString()));

//		System.out.println(data.getDiscriminator());
//		System.out.println(data.getPayload());
	}

	@Test
	public void testDump()
	{
		datasource.dump();
	}

	@Test
	public void testGet()
	{
		String json = datasource.execute(new Data(Discriminators.Uri.GET, "048").asJson());
		System.out.println(json);
	}
}
