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
import org.lappsgrid.api.DataSource;
import org.lappsgrid.serialization.Data;
import org.lappsgrid.serialization.Serializer;

import java.util.List;
import static org.lappsgrid.discriminator.Discriminators.*;
import static org.junit.Assert.*;

/**
 * @author Keith Suderman
 */
public class SquadTests
{
	private DataSource source;

	@Before
	public void setup()
	{
		System.setProperty(GenericDatasource.PROPERTY_NAME, "/var/corpora/Squad-dev-1.1");
		source = new GenericDatasource();
	}

	@After
	public void teardown()
	{
		source = null;
	}

	@Test
	public void testSize()
	{
		Data<String> query = new Data<>(Uri.SIZE, null);
		String json = source.execute(query.asJson());
		Data data = Serializer.parse(json, Data.class);
		assert Uri.OK.equals(data.getDiscriminator());
		int size = Integer.parseInt(data.getPayload().toString());
		System.out.println("Size is " + size);
		assert 48 == size;
	}

	@Test
	public void tesList()
	{
		Data<String> query = new Data<>(Uri.LIST, null);
		String json = source.execute(query.asJson());
		Data data = Serializer.parse(json, Data.class);
		assert  Uri.STRING_LIST.equals(data.getDiscriminator());
//		assertEquals(data.getPayload().toString(), Uri.STRING_LIST, data.getDiscriminator());
		List<String> list = (List) data.getPayload();
		System.out.println("Size is " + list.size());
		assert 48 == list.size();
	}

	@Test
	public void testMetadata() {
		String json = source.getMetadata();
		Data data = Serializer.parse(json, Data.class);
		System.out.println(data.asPrettyJson());
	}

}
