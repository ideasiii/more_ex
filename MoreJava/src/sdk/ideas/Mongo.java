package sdk.ideas;

import java.util.ArrayList;
import java.util.HashMap;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.MongoClient;

public class Mongo
{

	static public class Filter
	{
		public String strField;
		public HashMap<String, String> mapFilter;

		public Filter()
		{
			mapFilter = new HashMap<String, String>();
		}

		@Override
		protected void finalize() throws Throwable
		{
			mapFilter.clear();
			mapFilter = null;
			strField = null;
			super.finalize();
		}
	}

	MongoClient mongo = null;

	public Mongo()
	{

	}

	public MongoClient Connect(String strIP, int nPort)
	{
		if (null != mongo)
			mongo.close();
		mongo = new MongoClient(strIP, nPort);
		return mongo;
	}

	@Override
	protected void finalize() throws Throwable
	{
		close();
		super.finalize();
	}

	public void close()
	{
		if (null != mongo)
		{
			mongo.close();
			mongo = null;
		}
	}

	@SuppressWarnings("deprecation")
	public int query(final String strDB, final String strCollection, final ArrayList<Filter> listFilter,
			ArrayList<String> listResult)
	{
		DB db = mongo.getDB(strDB);
		if (null != db)
		{
			DBCollection collection = db.getCollection(strCollection);
			if (null != collection)
			{

				DBCursor cursor = null;
				if (null != listFilter && 0 < listFilter.size())
				{
					Filter filter = null;
					String strField = null;
					BasicDBObject filterQuery = new BasicDBObject();
					for (int i = 0; i < listFilter.size(); ++i)
					{
						filter = listFilter.get(i);
						BasicDBObject subFilter = new BasicDBObject();

						for (Object key : filter.mapFilter.keySet())
						{
							strField = (String) key;
							subFilter.append(strField, filter.mapFilter.get(key));
							if (strField.trim().equals("$regex"))
							{
								subFilter.append("$options", "i");
							}
						}
						filterQuery.put(filter.strField, subFilter);
					}

					cursor = collection.find(filterQuery);
					System.out.println(filterQuery.toString());
				} else
				{
					cursor = collection.find();
				}

				while (cursor.hasNext())
				{
					listResult.add(cursor.next().toString());
				}
			}
		}

		return listResult.size();
	}

}
